require 'spec_helper'

class OmniAuthenticator; end

describe SessionsController do
  let(:user){ mock_model(User, :id => 42).as_null_object }
  let(:doorman){ double('omni_authenticator', :find_user => user)}

  describe "#create" do
    context "when successful" do

      before(:each) do
        OmniAuthenticator.stub(:new => doorman)
      end

      it "signs in the user" do
        post :create
        session[:user_id].should == 42
      end

      it "redirects to the account page" do
        post :create
        response.should redirect_to(edit_account_path)
      end

      it "tracks a new subscription" do
        user.stub(:subscribed_email => 'foo@bar.com',
                  :first_sign_in? => true,
                  :had_existing_subscription? => false,
                  :opted_out? => false)
        controller.analytical.should_receive(:event).with(:sign_up, {:id=>42}).ordered
        controller.analytical.should_receive(:event).with(:subscribe, :email => 'foo@bar.com').ordered
        controller.analytical.should_receive(:event).with(:sign_in, {:id=>42}).ordered
        post :create
      end
    end
  end
end
