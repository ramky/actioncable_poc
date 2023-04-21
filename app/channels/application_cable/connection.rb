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
          # Store uuid with author. We open a connection for every websocket client
          # (not for author, but in the poc is equivalent, and that's why I store together)
          oAuth = Author.find(author)
          if !oAuth.nil?
            oAuth.update(uuid: self.uuid)
          end
        end
      else
        # If we don't have token, reject connection.
        reject_unauthorized_connection
      end
    end
  end
end
