class BroadcastController < ApplicationController
  def index
    render json: {status: :ok}
  end

  def show
    completion_response = {
      body: 'tmp ' + Faker::Book.title,
      command: 'close'
    }

    # Call Kafka with the book
    message = { 'uuid' => params[:uuid], 'author' => '1' }.to_json
    Karafka.producer.produce_sync(topic: 'author', payload: message)

    # Now, this is in the books_consumer
    #ActionCable.server.broadcast("books_#{params[:uuid]}", completion_response)

    #render json: completion_response
  end

  def renderbooks(response)
    render json: response
  end
end