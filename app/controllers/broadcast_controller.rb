class BroadcastController < ApplicationController
  def index
    render json: {status: :ok}
  end

  #  TODO:
  #  instead of triggering this via controller
  #  when karaka receives the request it will have a UUID, it needs to make a perform_later (sidekiq) call
  #  to send the response and set the close command so the client can close the connection
  def show
    completion_response = {
      body: Faker::Book.title,
      command: 'close'
    }
    ActionCable.server.broadcast("books_#{params[:uuid]}", completion_response)

    render json: completion_response
  end
end