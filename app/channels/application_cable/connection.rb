module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :uuid
    #attr_reader :author, :uuid

    def connect
      token = self.request.params[:Authorization]
      author = self.request.params[:Author]
      #path = self.request.filtered_path
      #if path.include?('Authorization')
      # token = path[path.rindex('Authorization=')+14..]
      if !token.nil?
        huser = JsonWebToken.decode(token)
        if huser.nil? || User.find(huser[:user_id]).nil?
          reject_unauthorized_connection
        else
          self.uuid = SecureRandom.urlsafe_base64
          #ActionCable.server.broadcast("books_#{self.uuid}", self.uuid)
          # Store uuid with author. We open a connection for every websocket client (not for author, but in the poc is equivalent, and that's why I store together)
          oAuth = Author.find(author)
          oAuth.update(uuid: self.uuid)
          #oAuth.uuid = self.uuid
          #oAuth.save
        end
      else
        reject_unauthorized_connection
      end
    end
  end
end
