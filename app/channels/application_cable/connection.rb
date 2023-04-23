module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :uuid
    #attr_reader :author, :uuid

    def connect
      token = self.request.params[:Authorization]
      author = self.request.params[:Author]
      if !token.nil?
        huser = JsonWebToken.decode(token)
        if huser.nil? || User.find(huser[:user_id]).nil?
          # If token is not correct, reject connection
          reject_unauthorized_connection
        else
          # Generates uuid that identifies connection.
          self.uuid = SecureRandom.urlsafe_base64
          begin
            oAuth = Author.find(author)
            if !oAuth.nil?
              # If we store uuid with author: We open a connection for every websocket client
              # (not for author, but in the poc is equivalent, and that's why I could store together)
              #oAuth.update(uuid: self.uuid)
              # Finally, I store the relation between uuid and author in a new table: conns
              oConn = Conn.create(uuid: self.uuid.to_s, author: author)
            end
          rescue => e
            # If we don't find author in DB, reject connection.
            # ()If we want to allow connection, broadcast controller can control if client doesn't exist and close connection later.)
            reject_unauthorized_connection
          end
        end
      else
        # If we don't have token, reject connection.
        reject_unauthorized_connection
      end
    end
  end
end
