module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :uuid

    # TODO:
    # 1) client should first authenticate and will be issued a JWT and that needs to accompany subsequent calls
    # 2) change identified_by to a User record in DB - create and run migrations first
    # 3) let us seed 5 users so everyone will have it
    # 4) TBD - do we need client UUID additional to the JWT
    # if we do then we need to store in the current_user (User in DB) -
    # this will help us find and close the connection
    def connect
      self.uuid = SecureRandom.urlsafe_base64
    end
  end
end
