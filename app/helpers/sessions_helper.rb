module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    #!はnot、current_userメソッドでログインユーザが見つかればtrue→false→true
    #見つからなければnil→true→false
    !!current_user
  end
end
