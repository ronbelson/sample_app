module SessionsHelper
  
  def authentication
    deny_access( :flash_text => "Please Signin" , :path => signin_path) unless signed_in?
  end
  
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_cookies
  end 
  
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  def current_user?(user)
    current_user == user
  end
  
  def deny_access(options = { :path => signin_path ,  :flash_text => nil })
     cookies[:come_from] = request.fullpath 
     flash[:notice] = options[:flash_text] unless options[:flash_text].nil?
     redirect_to(options[:path])
  end
  
  
  private
  
  def user_from_remember_cookies
    User.authenticate_with_salt(*user_remember_cookies)
  end
  
  def user_remember_cookies
      cookies.signed[:remember_token] || [nil, nil]
  end
  
end
