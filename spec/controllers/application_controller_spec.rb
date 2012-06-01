require "spec_helper"

describe ApplicationController do
  let(:secret){ Bjjlife::Application.config.secret_token }
  let(:verifier){ ActiveSupport::MessageVerifier.new(secret) }

  describe "signing in a user" do
    controller do
      def index
        sign_in(User.find(42))
        render :nothing => true
      end
    end

    let(:user){ mock_model(User, :id => 42).as_null_object }

    before(:each) do
      User.stub(:find => user)
    end

    it "sets a session user_id " do
      get :index
      session[:user_id].should == 42
    end

    it "sets a flash notice " do
      get :index
      flash[:notice].should == "Signed in successfully."
    end

    it "sets a cookie" do
      get :index
      verifier.verify(response.cookies['remember_me']).should == 42
    end
  end

  describe "signing out a user" do
    controller do
      def index
        sign_out
        render :nothing => true
      end
    end

    it "clears the session user_id " do
      get :index
      session[:user_id].should be_nil
    end

    it "sets a flash notice " do
      get :index
      flash[:notice].should == "Signed out!"
    end

    it "clears the cookie" do
      get :index
      response.cookies['remember_me'].should be_nil
    end
  end
end
