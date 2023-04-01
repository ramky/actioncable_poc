class BroadcastController < ApplicationController
  COMPLETION_RESPONSE = {
    body: 'some book',
    command: 'close',
  }

  def index
    render json: {status: :ok}
  end

  def show
    ActionCable.server.broadcast("books_#{params[:uuid]}", COMPLETION_RESPONSE)

    render json: COMPLETION_RESPONSE
  end
end