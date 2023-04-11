# frozen_string_literal: true

# Example consumer that consumes the events topic and stores data into events table
class BooksConsumer < ApplicationConsumer
  # Consumes the messages by inserting all of them in one go into the DB
  def consume
    fullMessage = ''
    messages.each do |message|
      Karafka.logger.info "Consumed following message: #{message.payload}"
      fullMessage = fullMessage + message.payload
    end
    completion_response = {
      #body: Faker::Book.title,
      body: fullMessage,
      command: 'close'
    }
    ActionCable.server.broadcast("books_#{params[:uuid]}", completion_response)
  end
end
