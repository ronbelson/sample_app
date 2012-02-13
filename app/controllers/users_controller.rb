class UsersController < ApplicationController
  
  before_filter  :authentication,  :only => [:edit , :show , :update , :index ]
  before_filter  :correct_user,  :only => [:edit , :update]
  
   
  # GET /useres/
  def index
    @title = "Users List"
    @users = User.paginate(:page => params[:page])
  end
   
  # GET /users/1
  # GET /users/1.json
  def show 
    @user = User.find(params[:id])
    @title = @user.name
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @title = "Signup"
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @title = "Edit User"
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "welcome to sample app"
      redirect_to @user 
    else
      @title = "Signup" 
      render action: "new" 
      #format.json { render json: @user }
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
     flash[:success] = "successfully updated"
     redirect_to @user 
    else
      @title = "Edit User"
      render action: "edit" 
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  def authentication
    deny_access( :flash_text => "Please Signin" , :path => signin_path) unless signed_in?
  end 
  
  def correct_user
     deny_access( :path => root_path) unless correct_user?
  end 
  
   def correct_user?
    user =  User.find(params[:id]) 
    current_user?(user)
   end
  
end






