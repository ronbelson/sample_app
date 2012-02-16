require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
                        :content => "Ruby on Rails Tutorial Sample App | Home")
    end
    
    describe "Home for register user" do                    
       before(:each) do
         @user = Factory(:user)
         test_sign_in(@user)
         @other_user = Factory(:user, :email => "email@email.com")
         @other_user.follow!(@user)
         @user.follow!(@other_user)
       end
       it "should have title user name" do
         get 'home'
         response.should have_selector("title",
                           :content => "Ruby on Rails Tutorial Sample App | #{@user.name}")
       end
       
       it "should have 1 follower" do
          get 'home'
          response.should have_selector("a",
                            :content => "followers",
                            :href => followers_user_path(@user))
        end
        
         it "should  followed 1 friend" do
            get 'home'
            response.should have_selector("a",
                              :content => "followed",
                              :href => following_user_path(@user))
          end
          
     end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                        :content =>
                          "Ruby on Rails Tutorial Sample App | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                        :content =>
                          "Ruby on Rails Tutorial Sample App | About")
    end



  end
end