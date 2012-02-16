require "spec_helper"

describe User do
  
  before (:each) do
    @atrr = { :name => 'Test user',
              :email => 'hello@gmail.com',
              :password => '121212',
              :password_confirmation => '121212'}
  end
  
  describe "user relationsheep" do
    
    before(:each) do
      @user = User.create!(@atrr)
      @followed = Factory(:user)
    end
    
    it "should have a relationships method" do
         @user.should respond_to(:relationships)
       end

       it "should have a following method" do
         @user.should respond_to(:following)
       end

       it "should follow another user" do
         @user.follow!(@followed)
         @user.should be_following(@followed)
       end

       it "should include the followed user in the following array" do
         @user.follow!(@followed)
         @user.following.should include(@followed)
       end

       it "should have an unfollow! method" do
         @user.should respond_to(:unfollow!)
       end

       it "should unfollow a user" do
         @user.follow!(@followed)
         @user.unfollow!(@followed)
         @user.should_not be_following(@followed)
       end
 
       it "should have a reverse_relationships method" do
         @user.should respond_to(:reverse_relationships)
       end

       it "should have a followers method" do
         @user.should respond_to(:followers)
       end

       it "should include the follower in the followers array" do
         @user.follow!(@followed)
         @followed.followers.should include(@user)
       end
    
  end
  
  

   describe  "micropost associations" do
    it "should have many micropsts" do
      @user = User.create!(@atrr)
      @user.should respond_to(:microposts)
    end
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

  describe "admin" do
    before(:each) do
     @user = User.create!(@atrr)
    end
    
    it "should not be admin" do
      @user.should_not be_admin
    end
    
    it "should be admin" do
      @user.toggle!(:admin)  
      @user.should be_admin
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

    describe "has_password? method"   do

      it "should user response to method? " do
        @user.should respond_to(:has_password?)
      end


      it "should retrun true if submited password match to encrypted password" do
        @user.has_password?(@atrr[:password]).should be_true
      end

      it "should retrun false if submited password not match to encrypted password" do
        @user.has_password?('invalid').should be_false
      end

    end

    describe "authenticate method"   do

      it "should return user object" do
        User.authenticate(@atrr[:email],@atrr[:password]) == @user
      end

       it "should return false" do
        User.authenticate(@atrr[:email],"invalid").should be_nil
      end

    end

  end

end