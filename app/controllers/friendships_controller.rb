class FriendshipsController < ApplicationController
  before_filter :signed_in_user

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:success] = "Friend added: #{User.find(params[:friend_id]).name}"
      redirect_to users_path
    else
      flash[:error] = "Unable to add friend"
      redirect_to users_path
    end
  end
  
  def destroy
    @friendship = current_user.friendships.find(params[:id])
    flash[:warning] = "You have ended friendship with #{User.find(@friendship.friend_id).name}"
    @friendship.destroy
    redirect_to current_user
  end

  def ignore
  end

  def approve
      @friendship = current_user.indirect_friendships.find(params[:id])
      @friendship.approved = true
      if @friendship.save
        flash[:success] = "Is approved: #{@friendship.approved} by  User_ID: #{current_user.id}, and Current_user.NAME: #{current_user.name} have accepted #{User.find(Friendship.find(params[:id]).user_id).name} as a friend"
        redirect_to current_user
      else
        flash[:success] = "Is not approved"
        redirect_to current_user
      end
  end

  def index
    
  end

end
