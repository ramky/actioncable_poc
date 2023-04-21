class BroadcastController < ApplicationController
  def index
    render json: {status: :ok}
  end

  def show
    begin
      oAuth = Author.find_by(uuid: params[:uuid])

      # Call Kafka with the book
      message = { 'uuid' => params[:uuid], 'author' => oAuth.id }.to_json
      Karafka.producer.produce_async(topic: 'author', payload: message)

      render json: {body: 'Your request is being processed. Awaiting for the server2 response'}
    rescue
      render json: {body: "Sorry, this author doesn't exist in the DB"}
    end
  end

  def renderbooks(response)
    render json: response
  end
end