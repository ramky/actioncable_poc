# frozen_string_literal: true

require_relative '../../lib/book_message/book_pb'
include BookMessage

# Example consumer that consumes the events topic and stores data into events table
class BooksConsumer < ApplicationConsumer
  def getBooksFromArray(booksArray)
    books = ''
    booksArray.each do |book|
      if books.length > 0
        books = books + ','
      end
      books = books + book
    end
    books
  end

  # Consumes the messages by inserting all of them in one go into the DB
  def consume
    fullMessage = ''
    bc = BroadcastController.new

    messages.each do |message|
      # Old JSON processing
      #Karafka.logger.info "Consumed following message: #{message.payload}"
      #author_name = Author.find(message.payload['author']).name
      # in completion_response:
      #body: author_name + ',' + message.payload["books"],
      #ActionCable.server.broadcast("books_#{message.payload['uuid']}", completion_response)

      proto_message = Book.decode(message.raw_payload)

      author_name = Author.find(proto_message.author).name
      completion_response = {
        body: author_name + ',' + getBooksFromArray(proto_message.title),
        command: 'close'
      }
      mark_as_consumed!(messages.last)
      ActionCable.server.broadcast("books_#{proto_message.uuid}", completion_response)
    end

  end
end
