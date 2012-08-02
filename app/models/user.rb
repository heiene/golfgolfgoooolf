# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#  global_admin    :boolean
#  local_admin     :boolean
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  admin           :boolean         default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  VALID_EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_FORMAT }

  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  before_save do 
    self.email.downcase!
    create_remember_token
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    
end
