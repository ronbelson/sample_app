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
    redirect_to(user_path(current_user))  unless !signed_in?
  end
end
