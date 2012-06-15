require 'spec_helper'

class OmniAuthenticator; end

describe SessionsController do
  let(:user){ mock_model(User, :id => 42).as_null_object }
  let(:doorman){ double('omni_authenticator', :find_user => user)}

  it "should not reek" do
    get_source_file(__FILE__).should_not reek
  end

  describe "#create" do
    let(:params){ {:provider => 'identity'} }
    context "when successful" do
      before(:each) do
        OmniAuthenticator.stub(:new => doorman)
      end

      it "signs in the user" do
        post :create, params
        session[:user_id].should == 42
      end

      it "sets a flash notice " do
        post :create, params
        flash[:notice].should == "You are now signed in."
      end

      it "redirects to the account page" do
        post :create, params
        response.should redirect_to(edit_account_path)
      end

      it "redirects to a stored location" do
        user.stub(:first_sign_in? => false)
        controller.send(:store_location, '/foo')
        post :create, params
        response.should redirect_to('/foo')
      end

      it "tracks a new subscription" do
        user.stub(:subscribed_email => 'foo@bar.com',
                  :first_sign_in? => true,
                  :had_existing_subscription? => false,
                  :opted_out? => false)

        controller.analytical.should_receive(:event).with(:sign_in, {:id => 42}).ordered
        controller.analytical.should_receive(:event).with(:sign_up, {:id => 42}).ordered
        controller.analytical.should_receive(:event).with(:subscribe, :email => 'foo@bar.com').ordered
        post :create, params
      end
    end

    context "when failed" do
      it "redirects to the sign in page" do
        get :failure
        response.should redirect_to(sign_in_url)
      end
      it "sets a flash message" do
        request.stub(:env => {'omniauth.error.type' => 'omniauth.invalid_credentials'})
        get :failure
        flash[:alert].should == 'Your email address or password is incorrect'
      end
    end
  end

  describe "#destroy" do
    let(:user){ mock_model(User, :model => true) }
    before(:each) do
      controller.stub(:current_user => user)
    end
    it "signs out the user" do
      get :destroy
      session[:user_id].should == nil
    end
    it "sets a flash notice " do
      get :destroy
      flash[:notice].should == "You are now signed out."
    end
    it "tracks the event" do
      controller.analytical.should_receive(:event).with(:sign_out, :id => user.id)
      get :destroy
    end
    it "redirects to the account page" do
      get :destroy
      response.should redirect_to(root_path)
    end
  end
end
