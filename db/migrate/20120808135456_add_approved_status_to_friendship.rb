class AddApprovedStatusToFriendship < ActiveRecord::Migration
  def change
    add_column :friendships, :approved, :boolean
  end
end
