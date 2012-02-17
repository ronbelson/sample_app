class UsersController < ApplicationController
  
  before_filter   :authentication,  :only => [ :edit , :show , :update , :index , :destroy ]
  before_filter   :correct_user,    :only => [ :edit , :update ]
  before_filter   :admin_user,    :only => [ :destroy ]
   
  # GET /useres/
  def index
    @title = "Users List"
    
    if params[:q] 
      if params[:page] == "1"
        flash[:notice] = "search results for #{params[:q]}"
      end
      @users = User.paginate(:conditions => ['email = ?', "#{params[:q]}"], :page => params[:page])
    else
      @users =  User.paginate(:page => params[:page])
    end
    
  end
   
  # GET /users/1
  # GET /users/1.json
  def show 
    @user = User.find(params[:id])
    @micropost = Micropost.new
    @title = @user.name
    @microposts = @user.microposts.paginate(:page => params[:page])
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
      Notifier.welcome(@user.name).deliver
      flash[:success] = "welcome to sample app"
      redirect_to cookies[:come_from] || user_path(@user)
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
  
  def followers
     @title = "Followers users"
     @user =  User.find_by_id(params[:id])
      if params[:q] 
        if params[:page] == "1"
          flash[:notice] = "search results for #{params[:q]}"
        end
        @users = @user.followers.paginate(:conditions => ['email = ?', "#{params[:q]}"], :page => params[:page])
      else
        @users = @user.followers.paginate(:page => params[:page])
      end
      render 'index'
  end
  
  def following
     @user =  User.find_by_id(params[:id])
     @title = "Following users"
      if params[:q] 
        if params[:page] == "1"
          flash[:notice] = "search results for #{params[:q]}"
        end
        @users =  @user.following.paginate(:conditions => ['email = ?', "#{params[:q]}"], :page => params[:page])
      else
        @users =  @user.following.paginate(:page => params[:page])
      end
      render 'index'
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy unless  delete_admin_user?(@user) #don't destroy admin user it self
    flash[:success] = "done"  
    redirect_to users_path
  end
  
  def correct_user
     deny_access( :path => root_path) unless correct_user?
  end 
  
   def correct_user?
    user =  User.find(params[:id]) 
    current_user?(user)
   end
   
  def admin_user
    user = User.find(params[:id]) 
    redirect_to(root_path) unless current_user.admin?
  end
   
   def delete_admin_user?(user)
    current_user == user
   end
end






