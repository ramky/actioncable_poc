module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :uuid

    def connect
      path = self.request.filtered_path
      if path.include?('Authorization')
        token = path[path.rindex('Authorization=')+14..]

        huser = JsonWebToken.decode(token)
        if huser.nil? || User.find(huser[:user_id]).nil?
          reject_unauthorized_connection
        else
          self.uuid = SecureRandom.urlsafe_base64
        end
      end
    end
  end
end
