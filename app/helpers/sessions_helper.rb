module SessionsHelper

  def sign_in(user)
    if params[:remember_me]
      cookies.permanent[:remember_token] = user.remember_token
      self.current_user = user
      flash[:success] = "du har valgt aa forbli innlogga"
    else
      #Mulig man bør legge på en if remember token er tom? Lurt å bruke sign_in flere steder,
      #det er viktig for å motvirke session hijacks
      #blant annet anbefalt å kjøre en sign_in på user_controller update (kun kopiert fra tut)
      #får se
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
