class RemoveDefaultApprovedToFriendship < ActiveRecord::Migration
  def up
    remove_column :friendships, :approved
  end

  def down
    add_column :friendships, :approved, :boolean, default: false
  end
end
