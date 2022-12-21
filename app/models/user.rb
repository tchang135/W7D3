# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6}

     after_initialize :ensure_session_token

     attr_reader :password

     def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user && is_password?(password)
            return user
        else
            nil
        end
     end

     def is_password?(new_pass)
        pass_obj = BCrypt::Password.new(self.password_digest)
        pass_obj.is_password?(new_pass)
     end

     def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password

     end

    has_many :goals,
    primary_key: :id,
    foreign_key: :owner_id,
    class_name: :Goal
    
    def ensure_session_token
        self.session_token ||= generate_unique_session_token
    end

   

    
    def generate_unique_session_token
        SecureRandom::urlsafe_base64
    end
end
