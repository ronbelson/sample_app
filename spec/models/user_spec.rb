require "spec_helper"

describe User do

  before (:each) do
    @atrr = { :name => 'ron belson',
              :email => 'ronbelson@gmail.com',
              :password => "121212",
              :password_confirmation => "121212"}
  end

  it "should create new user object instance" do
    User.create!(@atrr)
  end

  it "should requrie a name" do
    no_name_user = User.new(@atrr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should requrie a email" do
    no_name_user = User.new(@atrr.merge(:email => ""))
    no_name_user.should_not be_valid
  end

  it "should not create new user with duplicate email" do
    User.create(@atrr)
    duplicate_user = User.new(@atrr)
    duplicate_user.should_not be_valid
  end

  it "should not create new user with invalid email address" do
    User.create(@atrr.merge(:email => "ron.belson")).should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    User.create!(@atrr.merge(:email => @atrr[:email].upcase))
  end

  describe "paswword validation" do

     it "should requrie a password" do
      User.new(@atrr.merge(:password => "", :password_confirmation =>"")).
          should_not be_valid
     end

     it "should requrie a match password and password_confirmation" do
      password_confirmation = "a" *5
      User.new(@atrr.merge(:password => "", :password_confirmation => password_confirmation)).
          should_not be_valid
     end

     it "should reject short password" do
       password = "a" *3
       User.new(@atrr.merge(:password => password, :password_confirmation => password)).
          should_not be_valid

     end

    it "should reject long password" do
       password = "a" *21
       User.new(@atrr.merge(:password => password, :password_confirmation => password)).
          should_not be_valid

    end

  end

  describe "password encription"   do

    before(:each) do
     @user = User.create!(@atrr)
    end

   it "should have an encrypted password attribute" do
    @user.should respond_to(:encripted_password)
   end

   it "should set the encrypted password" do
      @user.encripted_password.should_not be_blank
    end


  end

end