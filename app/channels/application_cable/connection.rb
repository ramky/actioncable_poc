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
        end
      else
        reject_unauthorized_connection
      end
    end
  end
end
