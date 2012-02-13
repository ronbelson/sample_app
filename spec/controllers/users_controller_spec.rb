require "rspec"

describe UsersController do
  render_views

  before (:each) do
   @user = Factory(:user)
  end

  describe "GET 'show'" do
    before(:each) do
       test_sign_in(@user)
    end
     it "should be seccessful" do
      
       get :show , :id => @user.id
       response.should be_success
     end
 
     it "should have user gravatar img" do
       get :show, :id => @user.id
       response.should have_selector("h1>img" , :class => "gravatar")
     end

     it "should have user name" do
       get :show, :id => @user.id
       response.should have_selector("h1", :content => @user.name)
     end
     
  end

 describe "GET 'new'" do
   it "shhould have title Signup" do
     get :new
     response.should have_selector("title", :content => "Signup")
   end
   
   it "should have h1 with signup message" do
     get :new
     response.should have_selector("h1", :content => "Signup") 
   end

 end  


 describe "POST 'create'" do
   before(:each) do
    @user =  {:name => "", :email => "", :password => "", :password_confirmation => ""}
   end
       
   describe "Invalid parameters for create" do
     
     it "should render new page with err" do
       post :create, :user => @user
       response.should render_template(:new)
     end   
     
     it "should not create user" do
        lambda do
          post :create, :user => @user
        end.should_not change(User, :count)  
     end
     
     
   end 
   
   describe "User create" do
     before(:each) do
       @new_user =  {:name => "ron belson", :email => "ron@gmail.com", :password => "121212", :password_confirmation => "121212"}
      end
     it "should create new user" do
       lambda do
         post :create, :user => @new_user #Factory(:user)
       end.should change(User, :count).by(1)    
     end   
     
     it "should redirect to user page" do
        post :create, :user => @new_user
        response.should redirect_to(user_path(assigns(:user)))
     end
     
     it "should redirect to user page with flash success" do
       post :create, :user => @new_user
       flash[:success].should =~ /welcome to sample app/i
     end
     
      it "should sign the user in" do
         post :create, :user => @new_user
        controller.should be_signed_in
      end
   end  
 end   

 describe "GET 'edit'"  do
   before(:each) do
    # @user = Factory(:user)
     test_sign_in(@user)
   end
   
   it "should should be success" do
     get :edit, :id => @user
     response.should be_success
   end
   
    it "should have title 'edit user'" do
      get :edit, :id => @user
      response.should have_selector('title', :content => 'Edit User')
    end   
 end
 
 
 describe "PUT 'update' fail" do

    before (:each) do
       test_sign_in(@user)
       @update_atrr = { :name => '',
                          :email => 'l.com',
                          :password => '',
                          :password_confirmation => '121212'}
    end
    it "shlould render edit page" do
      put :update, :id => @user, :user => @update_atrr
      should render_template(:edit)
    end
     it "shlould have selector error" do
        put :update, :id => @user, :user => @update_atrr
        response.should have_selector('title', :content => 'Edit User')
      end
 end
  
 describe "PUT 'update' successful" do
   
   before (:each) do
      test_sign_in(@user)
      @update_atrr = { :name => 'ronron',
                         :email => 'ronron@gmail.com',
                         :password => '121212',
                         :password_confirmation => '121212'}
   end
  
    it "should user change attribute" do
       put :update, :id => @user, :user => @update_atrr
       @user.reload
       @user.email.should == @update_atrr[:email]
    end
    
    it "should user redirect to user page attribute" do
       put :update, :id => @user, :user => @update_atrr
       response.should redirect_to(user_path(assigns(@user)))
    end
    
    it "should have a flash message" do
       put :update, :id => @user, :user => @update_atrr
       flash[:success].should =~ /successfully updated/
     end
 end
 
 describe "User authenticated "
   it"Should redirect to signin page of user not authenticate" do
     get :show, :id => @user
     response.should redirect_to(signin_path)
   end
   
   it "Should redirect to home page is the corrent user edit ather user" do
      test_sign_in(@user)
      @another_user = Factory(:user, :email => 'roron@roron.com')
      get :edit, :id => @another_user
      response.should redirect_to(root_path) 
   end
   
end