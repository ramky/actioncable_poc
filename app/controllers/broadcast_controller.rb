class BroadcastController < ApplicationController
  def index
    render json: {status: :ok}
  end

  def show
    begin
      # Takes uuid and look for author associated
      oConn = Conn.find_by(uuid: params[:uuid])
      oAuth = Author.find(oConn.author)

      # Call Kafka with the book
      message = { 'uuid' => params[:uuid], 'author' => oAuth.id }.to_json
      Karafka.producer.produce_async(topic: 'author', payload: message)

      render json: {body: 'Your request is being processed. Awaiting for the server2 response'}
    rescue
      render json: {body: "Sorry, this author doesn't exist in the DB"}
      # And we close the websocket connection because it's opened for a specific author in the POC.
      completion_response = {
        body: 'Author {oConn.author} unknown',
        command: 'close'
      }
      ActionCable.server.broadcast("books_#{params[:uuid]}", completion_response)
    end
  end

  def renderbooks(response)
    render json: response
  end
end