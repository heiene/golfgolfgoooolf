# == Schema Information
#
# Table name: friendships
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  friend_id  :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  approved   :boolean         default(FALSE)
#  visible    :boolean         default(TRUE)
#


class Friendship < ActiveRecord::Base
  attr_accessible :friend_id
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
  validates :friend_id, presence: true
  validates :user_id, presence: true


end
