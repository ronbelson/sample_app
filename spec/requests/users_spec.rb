require 'spec_helper'

describe "Users" do
  describe "sign in/out" do

      describe "failure" do
        it "should not sign a user in" do
          visit signin_path
          fill_in :email,    :with => ""
          fill_in :password, :with => ""
          click_button
          response.should have_selector("div.error", :content => "invalid user")
        end
      end

      describe "success" do
        it "should sign a user in and out" do
          user = Factory(:user)
          visit signin_path
          fill_in :email,    :with => user.email
          fill_in :password, :with => user.password
          click_button
          controller.should be_signed_in
          click_link "Sign out"
          controller.should_not be_signed_in
        end
      end
    end
    
    
  describe "signup" do
    
    describe "failur" do
      it "should no create new user" do
        lambda do
        visit signup_path
        fill_in "Name",            :with => ""
        fill_in "Email",            :with => ""
        fill_in "Password",            :with => ""
        fill_in "Password confirmation",   :with => ""
        click_button
        response.should render_template('users/new')
        response.should have_selector('div#error_explanation')
        end.should_not change(User, :count)
      end
      
       describe "success" do
          it "should  create new user" do
            lambda do
            visit signup_path
            fill_in "Name",            :with => "ron belson"
            fill_in "Email",            :with => "ronbod2@belson.com"
            fill_in "Password",            :with => "121212"
            fill_in "Password confirmation",   :with => "121212"
            click_button          
            response.should render_template('users/show')
            response.should have_selector('div.success', :content => "welcome to sample app")
            end.should change(User, :count).by(1)
          end
      end
    end
   end
   
   describe "update" do
     it "should faill" do
        user = Factory(:user)
         visit signin_path
         fill_in :email,    :with => user.email
         fill_in :password, :with => user.password
         click_button
         visit edit_user_path(user)
         fill_in :email,    :with => ""
         fill_in :name, :with => ""
         fill_in :password,    :with => ""
         click_button
         response.should render_template('users/edit')
     end
     
     it "should succssesful" do
         user = Factory(:user)
          visit signin_path
          fill_in :email,    :with => user.email
          fill_in :password, :with => user.password
          click_button
          visit edit_user_path(user)
          fill_in :email,    :with => "roron@gmail.com"
          fill_in :name, :with => "ronron"
          fill_in :password,    :with => "131313"
          fill_in "password confirmation", :with => "131313"
          click_button 
          response.should render_template('users/show')
          response.should have_selector('div.success', :content => "successfully updated")
      end
   end
end