class SyncApiChannel < ApplicationCable::Channel
  def subscribed
    stream_from "books_#{uuid}"
    # Send uuid to client to associate with posterior broadcast call
    broadcast_to("books_#{uuid}", uuid)
    ActionCable.server.broadcast("books_#{uuid}", uuid)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
   puts "Received by server:"
   puts data
  end
end