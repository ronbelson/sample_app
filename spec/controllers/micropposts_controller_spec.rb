require 'spec_helper'

describe MicropostsController do
  render_views
  
  before(:each) do
    
     
    end
  
   describe "access control" do
     it "shoud not create micropost" do
       post :create
       response.should redirect_to(signin_path)
     end
     
     it "shoud not destroy micropost" do
       delete :destroy , :id => 45322 
       response.should redirect_to(signin_path)
      end
    
     it "should not destroy another user micropost " do
      @user = Factory(:user)
      @micropost = Factory(:micropost, :user => @user)
      annother_user = Factory(:user, :email => "new@new.com")
      test_sign_in(annother_user)
      delete :destroy, :id => @micropost
      response.should redirect_to(user_path(annother_user)) 
     end
   end
   
end
