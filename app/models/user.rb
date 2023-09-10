class User < ApplicationRecord
    validates_presence_of :email, :username
    validates_uniqueness_of :email, :username
    validates_presence_of :password_digest

    has_secure_password

end
