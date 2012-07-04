require 'spec_helper'

describe Admin::SubscriptionsController do
  include NullDB::RSpec::NullifiedDatabase
  include AuthHelper


  describe "GET #index" do
    subject { get :index }

    before(:each) do
      Subscription.stub(:all => [double('sub')])
      admin_login
    end

    it { should render_template("index") }
  end
end
