class AddDefaultApprovedToFriendship2 < ActiveRecord::Migration
  def change
    add_column :friendships, :approved, :boolean, default: true
  end
end
