class SessionsController < ApplicationController
  def new
    redirect_to root_path unless !signed_in?
    @title = "Signin"
  end
  
  def create
   user = User.authenticate(params[:session][:email],
                            params[:session][:password])
   if user.nil?
     @title = "Signin"
     flash.now[:error] = "invalid user/password"
     render :new
   else
     sign_in user
     flash[:success] = "welcome to sample app"
     redirect_to  cookies[:come_from] || user_path(user)
     cookies[:come_from] = nil  
   end
  end
  
  def destroy
     sign_out 
     redirect_to root_path
  end
  
  private 
  
  
end
