class MicropostsController < ApplicationController
  
  before_filter   :authentication,  :only => [:create , :destroy] #functoion on session_helper 
  before_filter  :micropost_belong_to_user,    :only => [:destroy ]
   
   def create
     @micropost = current_user.microposts.build(params[:micropost])
     if @micropost.save
       flash[:success] = "done!"
     else
       flash[:error] = "somthing wrong"
       @feed_items = []
     end
     
      
      redirect_to current_user
   end
  
   def destroy
     @micropost.destroy
     redirect_to user_path(current_user) , :flash => {:success =>  "done" } 
   end
   
   private
   
   def micropost_belong_to_user 
      redirect_to root_path unless current_user.microposts.find_by_id(params[:id]).nil?
   end
         
end
