class BroadcastController < ApplicationController
  def index
    render json: {status: :ok}
  end

  def show
    completion_response = {
      body: Faker::Book.title,
      command: 'close'
    }
    ActionCable.server.broadcast("books_#{params[:uuid]}", completion_response)

    render json: completion_response
  end
end