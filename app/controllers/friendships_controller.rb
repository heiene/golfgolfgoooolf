class FriendshipsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user
  # include FriendshipsHelper

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    # if   current_user.friendship_exists?(User.find(params[:friend_id]))
    #   current_user.friendship_exists?(User.find(params[:friend_id]))
    # end

    if @friendship.save
      flash[:success] = "Friendship requested with: #{User.find(params[:friend_id]).name}"
      redirect_to users_path
    else
      flash[:error] = "Unable to request friendship with user_id: #{@friendship.user_id}, friend_id #{@friendship.friend_id}, Approved status: #{@friendship.approved}, friendship_id: #{@friendship.id}"
      redirect_to users_path
    end
  end
  
  def destroy
    if @friendship = current_user.friendships.find_by_id(params[:id])
      flash[:warning] = "You have ended friendship with #{User.find(@friendship.friend_id).name}"
      @friendship.destroy  
      redirect_to users_path
    
    elsif @friendship = current_user.indirect_friendships.find_by_id(params[:id])
      flash[:warning] = "You have ended friendship with #{User.find(@friendship.user_id).name}"
      @friendship.destroy  
      redirect_to users_path
    else
      flash[:warning] = "You have ended cause you can't"
      redirect_to users_path
    end
    
  end

  def ignore
    @friendship = current_user.indirect_friendships.find(params[:id])
    before = @friendship.visible
    @friendship.visible = false

    if @friendship.save
      flash[:warning] = "You have ignored friendship with #{User.find(@friendship.friend_id).name} Visible status befor:#{before} and after: #{@friendship.visible}"
      redirect_to users_path
    else
      flash[:warning] = "Unable to ignore"
      redirect_to users_path
    end
  end

  def withdraw
    @friendship = current_user.friendships.find(params[:id])
    flash[:warning] = "You have withdrawn friendship with #{User.find(@friendship.friend_id).name}"
    @friendship.destroy
    redirect_to users_path
  end

  def reject
    @friendship = current_user.indirect_friendships.find(params[:id])
    flash[:warning] = "You have rejected friendship with #{User.find(@friendship.friend_id).name}"
    @friendship.destroy
    redirect_to users_path
  end

  def approve
      @friendship = current_user.indirect_friendships.find(params[:id])
      @friendship.approved = true
      if @friendship.save
        flash[:success] = "Is approved: #{@friendship.approved} by  User_ID: #{current_user.id}, and Current_user.NAME: #{current_user.name} have accepted #{User.find(Friendship.find(params[:id]).user_id).name} as a friend"
        # flash[:success] = "#{params}"
        redirect_to users_path
      else
        flash[:success] = "Is not approved"
        redirect_to users_path
      end
  end

  def index
    
  end
  def show
    
  end

  private
    def correct_user
      @user = User.find(params[:user_id])
      unless current_user?(@user)
        flash[:warning] = "not correct user"
        redirect_to root_path
      end
    end

end
