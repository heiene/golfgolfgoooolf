class AddVisibleToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :visible, :boolean, default: true
  end
end
