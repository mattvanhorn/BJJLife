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
    end
  end
end
