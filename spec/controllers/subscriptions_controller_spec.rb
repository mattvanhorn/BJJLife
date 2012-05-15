require 'spec_helper'

describe SubscriptionsController do

  describe "#new" do
    it "renders the correct template" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "#create" do
    let(:subscription){ double('subscription', :email => 'alice@example.com') }
    describe "with a valid email address" do
      it "creates a new subscription" do
        Subscription.should_receive(:new).with('email' => 'alice@example.com').and_return(subscription)
        subscription.should_receive(:save).and_return(true)
        post :create, :subscription => {:email => 'alice@example.com'}
      end

      it "redirects to a thank you page" do
        Subscription.stub(:new).and_return(subscription)
        subscription.stub(:save).and_return(true)
        post :create, :subscription => {:email => 'alice@example.com'}
        response.should redirect_to(thanks_subscriptions_url)
      end
    end
  end

  describe "#{}thanks" do
    it "renders the correct template" do
      get :thanks
      response.should render_template(:thanks)
    end
  end
end