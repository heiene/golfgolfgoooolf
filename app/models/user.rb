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
  
  #Defining the friendships relations
  has_many :friendships, dependent: :destroy
  has_many :direct_friends, through: :friendships, source: :friend, conditions: ['approved = ?', true]

  has_many :indirect_friendships, class_name: 'Friendship', foreign_key: "friend_id", dependent: :destroy
  has_many :indirect_friends, through: :indirect_friendships, conditions: ['approved = ?', true], source: :user

  has_many :pending_friendships, through: :friendships, conditions: ['approved = ?', false], foreign_key: "user_id", source: :friend
  has_many :requested_friendships, class_name: 'Friendship', foreign_key: "friend_id", conditions: ['approved = ?', false]

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

  def friends
    direct_friends | indirect_friends
  end

  # searchable do
  #   text :name, :email, :id
  # end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    
end
