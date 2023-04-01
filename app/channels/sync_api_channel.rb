class SyncApiChannel < ApplicationCable::Channel
  def subscribed
    stream_from "books_api"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
   puts "Received by server:"
   puts data
  end
end