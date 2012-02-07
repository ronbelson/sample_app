require "spec_helper"

describe User do

  before (:each) do
    @atrr = { :name => 'ron belson' , :email => 'ronbelson@gmail.com'}
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
    bad_email = @atrr.merge(:email => "ron.belson")
    User.create(:email => bad_email,:name => @atrr[:name]).should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    User.create!(:email => @atrr[:email].upcase  , :name => @atrr[:name])
  end

end