class BroadcastController < ApplicationController
  before_action :authenticate_request

  def index
    @users = User.all
    render json: {status: :ok}
  end

  #  TODO:
  #  instead of triggering this via controller
  #  when karaka receives the request it will have a UUID, it needs to make a perform_later (sidekiq) call
  #  to send the response and set the close command so the client can close the connection
  def show
    # @author = get_author_details(:bookId)



    completion_response = {
      body: Faker::Book.title,
      command: 'close'
    }
    ActionCable.server.broadcast("books_#{params[:uuid]}", completion_response)

    render json: completion_response
  end


  private
  def get_author_details(id)
    @author = Author.find(id)
  end
end