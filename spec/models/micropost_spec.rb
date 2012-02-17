require 'spec_helper'

describe Micropost do
  
  before(:each) do
    @user = Factory(:user)
    @micropost_content = { :content => "a" * 35 }
  end
  
  it "should create micropost" do
    micropost = @user.microposts.create!(@micropost_content)
    micropost.should_not be_nil
  end
  
  describe  "user associations" do
   
    before(:each) do
      @micropost = @user.microposts.create!(@micropost_content)
    end
    
    it "should micropost belong to user?" do
       @micropost.should respond_to(:user)
    end
    
    it "should have the right associated user" do
         @micropost.user_id.should == @user.id
         @micropost.user.should == @user
    end
   
     it "should have user id" do
       Micropost.create!(:content => "1").should be_valid
     end 
     
     it "should order micropost by created_at DESC" do
       mc1 =  Factory(:micropost , :content  => "111" , :user => @user , :created_at => 1.years.ago)
       mc2 =  Factory(:micropost , :content  => "222" , :user => @user , :created_at => 11.year.ago)
       @user.microposts.should == [@micropost, mc1 , mc2]
      end
      
      # it "should not include another user feeds" do
      #         @another_user = Factory(:user, :email => "new@new.com")
      #         mc3 =  Factory(:micropost , :content  => "222" , :user => @another_user , :created_at => 11.year.ago)
      #         @user.microposts.
      #       end
      
      it "should have user and followed user feeds only"  do
        u1 = Factory(:user , :email => "u1@u.com")
        u2 = Factory(:user , :email => "u2@u.com")
        u3 = Factory(:user , :email => "u3@u.com")                
        
        u1.follow!(u2)
        
        mc1 =  Factory(:micropost , :content  => "111" , :user => u1 , :created_at => 1.years.ago)
        mc2 =  Factory(:micropost , :content  => "222" , :user => u2 , :created_at => 11.year.ago)
        mc3 =  Factory(:micropost , :content  => "222" , :user => u3 , :created_at => 11.year.ago)        
        
        u1.feed.should include(mc1)
        u1.feed.should include(mc2)        
        u1.feed.should_not include(mc3)
      end
  end
  
  describe " Validation Matchers" do
  
    it "should validate presence" do
      @micropost_validation = @user.microposts.build(:content => "")
      @micropost_validation.should_not be_valid
    end
    
    it "should validate presence" do
      @micropost_validation = @user.microposts.build(:content => "a" * 141)
      @micropost_validation.should_not be_valid
    end
    
   
  end
  
end
