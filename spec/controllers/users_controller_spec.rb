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



end