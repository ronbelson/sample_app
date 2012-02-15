require 'spec_helper'

describe "FriendlyRedirects" do
  before(:each) do
    @user = Factory(:user)
  end
  it "should redirect to page after signin if user not register and come back after reg" do
     visit edit_user_path(@user)
     response.should have_selector('title', :content => 'Signin')      
     fill_in :email,    :with => @user.email
     fill_in :password, :with => @user.password
     click_button
     response.should have_selector('title', :content => 'Edit User')   
  end
  
  it "should redirect to home page if user try to edit another user page" do
    visit signin_path
    fill_in :email,    :with => @user.email
    fill_in :password, :with => @user.password
    click_button
    @another_user_attr = Factory(:user, :email =>'ron@wwm.com')
     visit edit_user_path(@another_user_attr)
     response.should have_selector('title', :content => @user.name )  #User profile 
  end
end
