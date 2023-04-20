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
      #Karafka.logger.info "Consumed following message: #{message.payload}"

      proto_message = Book.decode(message.raw_payload)

      #author_name = Author.find(message.payload['author']).name
      author_name = Author.find(proto_message.author).name
      completion_response = {
        #body: Faker::Book.title,
        #body: author_name + ',' + message.payload["books"],
        body: author_name + ',' + getBooksFromArray(proto_message.title),
        command: 'close'
      }
      mark_as_consumed!(messages.last)
      #ActionCable.server.broadcast("books_#{message.payload['uuid']}", completion_response)
      ActionCable.server.broadcast("books_#{proto_message.uuid}", completion_response)
      #bc.renderbooks(completion_response)
    end

  end
end
