require "rspec"

describe UsersController do
  render_views

  before (:each) do
   @user = Factory(:user)
  end

  describe "GET 'show'" do

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

end