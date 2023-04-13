# frozen_string_literal: true

# Example consumer that consumes the events topic and stores data into events table
class BooksConsumer < ApplicationConsumer
  # Consumes the messages by inserting all of them in one go into the DB
  def consume
    fullMessage = ''
    bc = BroadcastController.new

    messages.each do |message|
      Karafka.logger.info "Consumed following message: #{message.payload}"
      completion_response = {
        #body: Faker::Book.title,
        body: message.payload["books"],
        command: 'close'
      }
      bc.renderbooks(completion_response)
      ActionCable.server.broadcast("books_#{message.palyload['uuid']}", completion_response)
      mark_as_consumed!(messages.last)
    end

  end
end
