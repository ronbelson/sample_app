require 'spec_helper'

describe SessionsController do
  render_views
  
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
   end

end
