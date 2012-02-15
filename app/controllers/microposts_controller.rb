class MicropostsController < ApplicationController
  
  before_filter   :authentication,  :only => [:create , :destroy] #functoion on session_helper 
  before_filter   :micropost_belong_to_user,    :only => [:destroy ]
   
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
     @micropost = Micropost.find(params[:id])
     @micropost.destroy
     redirect_to user_path(current_user) , :flash => {:success =>  "done" } 
   end
   
   private
   
   def micropost_belong_to_user 
      @micropost = Micropost.find_by_id(params[:id])
      redirect_to user_path(current_user) , :flash => { :notice => "can't delete your friend feed" } unless current_user?(@micropost.user) 
      
   end
         
end
