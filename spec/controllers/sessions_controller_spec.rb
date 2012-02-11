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

end
