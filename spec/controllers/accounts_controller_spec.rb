require 'spec_helper'

describe AccountsController do
  let(:existing_identity){ mock_model(Identity) }
  let(:new_identity){ mock_model(Identity) }
  let(:user){ mock_model(User, :identity => existing_identity, :model => lambda{self}) }

  before(:each) do
    controller.stub(:locate_user => true)
  end


  describe "#new" do
    before :each do
      subject.stub(:user_signed_in => false)
      Identity.stub(:new => new_identity)
    end

    it "renders the new account template" do
      get :new
      response.should render_template :new
    end
  end

  describe "#edit" do

    it "authenticates the user" do
      subject.should_receive(:authenticate_user!).and_return(true)
      get :edit
    end

    context "with a logged in user" do
      before :each do
        subject.stub(:user_signed_in => true, :current_user => user)
      end

      it "renders the edit account template" do
        get :edit
        response.should render_template :edit
      end
    end

    context "with an anonymous user" do
      before :each do
        subject.stub(:user_signed_in => false)
      end

      it "redirects to the login page" do
        get :edit
        response.should redirect_to sign_in_url
      end
    end
  end

  describe "#update" do
    let(:current_user){ mock_model(User, :update_attributes => true, :identity => stub ) }
    let(:user_params){ {'username' => 'foobar', 'identity_attributes' => {'email' => 'bob@example.com'}} }
    before(:each) do
      controller.stub(:current_user => current_user)
    end
    it "updates the user & identity" do
      current_user.should_receive(:update_attributes).with(user_params).and_return(true)
      put :update, {'user' => user_params }
    end
    it "redirects to the home page" do
      put :update, {'user' => user_params}
      response.should redirect_to account_url
    end
  end

end
