class User < ApplicationRecord
    attr_accessor :remember_token
    before_save {self.email = email.downcase} #or before_save { email.downcase! }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 }, format: {with: VALID_EMAIL_REGEX}, uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    #you can use class << self or self.method instead of User.method
    # turn a sting to bcript
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    #create a random string
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # update remember_digest in database using the remember_token
    def remember 
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Returns true if the given token matches the digest.
    def authenticated?(remember_token)
        return false if remember_digest.nil? # if the remember_digest == nil return false
        # thereby this line will raise an error because compare to the nil value
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # delete the remember_digest in the database
    def forget
        update_attribute(:remember_digest, nil)
    end
end
