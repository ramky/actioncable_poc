class Author < ApplicationRecord

  require "securerandom"

  has_secure_password

  validates :email, presence: true, uniqueness:true
  validates :firstname, presence: true
  validates :lastname, presence: true

end
