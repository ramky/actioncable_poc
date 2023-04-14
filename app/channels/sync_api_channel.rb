class SyncApiChannel < ApplicationCable::Channel
  def subscribed
    stream_from "books_#{uuid}"
    #Don't work
    #self.broadcast_to("books_#{uuid}", { author: 'XXX', data: {'uuid' => uuid}})
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