require 'spec_helper'
describe SubscriptionsController do
  include NullDB::RSpec::NullifiedDatabase

  let(:subscription){ mock_model(Subscription).as_null_object }
  let(:videos){ stub('videos collection')}

  before(:each) do
    Subscription.stub(:new).and_return(subscription)
    Video.stub_chain(:scoped, :sample).and_return(videos)
    controller.stub(:locate_user => true)
  end


  describe "#new" do
    it "renders the correct template" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "#create" do
    describe "with a valid email address" do
      it "creates a new subscription" do
        subscription.should_receive(:save).and_return(true)
        post :create, :subscription => {:email => 'alice@example.com'}
      end

      it "redirects to a thank you page" do
        post :create, :subscription => {:email => 'alice@example.com'}
        response.should redirect_to(thanks_subscriptions_url)
      end
    end
  end

  describe "#thanks" do
    it "renders the correct template" do
      get :thanks
      response.should render_template(:thanks)
    end
  end
end
