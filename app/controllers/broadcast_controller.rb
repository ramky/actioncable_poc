class BroadcastController < ApplicationController
  def index
    render json: {status: :ok}
  end

  def show
    completion_response = {
      body: 'tmp ' + Faker::Book.title,
      command: 'close'
    }
    begin
      oAuth = Author.find_by(uuid: params[:uuid])

      # Call Kafka with the book
      message = { 'uuid' => params[:uuid], 'author' => oAuth.id }.to_json
      Karafka.producer.produce_async(topic: 'author', payload: message)

      # Now, this is in the books_consumer
      #ActionCable.server.broadcast("books_#{params[:uuid]}", completion_response)

      render json: {body: 'Your request is being processed. Awaiting for the server2 response'}
    rescue Exception => msg
      render json: {body: "Sorry, this author doesn't exist in the DB"}
    end
  end

  def renderbooks(response)
    render json: response
  end
end