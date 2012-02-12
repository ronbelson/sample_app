class SessionsController < ApplicationController
  def new
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
     redirect_to user
   end
  end
  
  def destroy
     sign_out 
     redirect_to root_path
  end
end
