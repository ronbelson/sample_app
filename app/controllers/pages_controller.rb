class PagesController < ApplicationController
   
   before_filter   :home_page,    :only => [ :home ]
   
  def home
    @title = "Home"
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end
  
  
  def home_page
    @title = "Home"
    if signed_in?
       # redirect_to(user_path(current_user))
       @user = current_user
       @micropost = Micropost.new
       @title = @user.name
       @microposts = @user.microposts.paginate(:page => params[:page])
       render "users/show"
    else
      render "pages/home"
    end

  end
end
