class SessionsController < ApplicationController
  def new
    @title = "Signin"
  end
  
  def create
   user = User.authenticate(params[:session][:email],
                            params[:session][:email])
   if user.nil?
     @title = "Signin"
     flash.now[:error] = "invalid user/password"
     render :new
   else
     render :new
   end
  end
  
  def destroy
    @title = "Signin"
     render :new
  end
end
