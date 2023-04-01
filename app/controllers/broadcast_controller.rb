class BroadcastController < ApplicationController
  COMPLETION_RESPONSE = {
    body: 'some book',
    command: 'close',
  }

  def index
    ActionCable.server.broadcast("books_api", COMPLETION_RESPONSE)

    render json: COMPLETION_RESPONSE
  end
end