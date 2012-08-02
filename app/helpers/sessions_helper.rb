module SessionsHelper

  def sign_in(user)
    if params[:remember_me]
      cookies.permanent[:remember_token] = user.remember_token
      self.current_user = user
      flash[:success] = "du har valgt aa forbli innlogga"
    else
      cookies[:remember_token] = user.remember_token
      self.current_user = user
    end
  end

  def signed_in?
   !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    if cookies[:remember_token]
      @current_user ||= User.find_by_remember_token(cookies[:remember_token])
    end
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

end
