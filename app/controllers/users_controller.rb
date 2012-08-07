class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index] # Signed_in_user er flyttet til sessionskontroller
                                                                # for å være tilgjengelig for andre klasser.
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to theGolfApp"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @Users = User.all
  end

  def destroy
    user = User.find(params[:id])
    if user == current_user
      flash[:warning] = "Cannot delete yourself"
    else
      user.destroy
      flash[:warning] = "user #{user.name} is deleted"
    end
    redirect_to users_path
  end

  private

    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:warning] = "not correct user"
        redirect_to root_path
      end
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end

end
