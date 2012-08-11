module FriendshipsHelper

  def friendship_exists?(user)
    
    current_user.friendships.each do |friend|
      if friend.friend_id == user.id
        return true, friend.id, "d"
      end 
    end
  
    current_user.indirect_friendships.each do |friend|
      if friend.user_id == user.id
        return true, friend.id, "i"
      end 
    end
    return false
  end

  def confirm_friendship_link(friendship_id, user_id)
    link_to "Confirm", controller: :friendships, action: :approve, id: friendship_id, user_id: user_id
  end

  def reject_friendship_link(friendship_id, user_id)
    link_to "Reject", controller: :friendships, action: :reject, id: friendship_id, user_id: user_id  
  end
  
  def ignore_friendship_link(friendship_id, user_id)
    link_to "Ignore", controller: :friendships, action: :ignore, id: friendship_id, user_id: user_id
  end

  def delete_friendship_link(friendship_id, user_id)
    link_to "End", controller: :friendships, action: :destroy, id: friendship_id, user_id: user_id, method: :delete
  end

  def withdraw_friendrequest_link(friendship_id, user_id)
    link_to "Withdraw", controller: :friendships, action: :withdraw, id: friendship_id, user_id: user_id, class:"btn btn-small"
  end

  def add_friendship_link( friend , user )
    link_to "Add friend" , friendships_path(friend_id: friend, user_id: user), method: :post, class:"btn btn-small"  
  end



end