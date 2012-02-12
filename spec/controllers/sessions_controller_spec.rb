require 'spec_helper'

describe SessionsController do
  render_views
  
   describe "DELETE 'destroy'" do

   it "should sign a user out" do
     test_sign_in(Factory(:user))
     delete :destroy
     controller.should_not be_signed_in
     response.should redirect_to(root_path)
   end
 end
     
  
  describe "GET 'new'" do
     it "shhould have title Signin" do
       get :new
       response.should have_selector("title", :content => "Signin")
     end

     it "should have h1 with signin message" do
       get :new
       response.should have_selector("h1", :content => "Signin") 
     end

   end

   describe "POST 'create'" do
     
     before(:each) do
       @user = {:email => "", :password => ""}
     end
     
     it "should return failuer" do
       post :create, :session => @user
       response.should render_template(:new)
     end
     
     it "should have an arr message" do
       post :create, :session => @user
       flash.now[:error].should =~ /invalid/i
     end
     
     describe "POST 'success'" do
       before(:each) do
        @user_factory = Factory(:user)
        @user_signin = {:email => @user_factory.email , :password => @user_factory.password }
       end
       it "should redirect to user profile page" do
          post :create, :session =>  @user_signin
          response.should redirect_to(user_path(@user_factory))
        end
        
       it "should signin user" do
         post :create, :session =>  @user_signin
         controller.should be_signed_in
       end
       
       it "should sign the user in" do
               post :create, :session => @user_signin
               controller.current_user.should == @user_factory
               controller.should be_signed_in
             end

        it "should redirect to the user show page" do
            post :create, :session => @user_signin
            response.should redirect_to(user_path(@user_factory))
        end

       
     end
     
   end

end