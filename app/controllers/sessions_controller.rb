class SessionsController < ApplicationController
  def new
    @title = "Signin"
  end
  
  def create
   @title = "Signin"
   render :new
  end
  
  def destroy
    @title = "Signin"
     render :new
  end
end
