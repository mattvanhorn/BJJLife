require 'spec_helper'

describe Admin::SubscriptionsController do
  before(:each) do
    Subscription.stub(:all => [double('sub')])
  end

  it "should not reek" do
    File.open(__FILE__).should_not reek
  end

  it { should expose(:subscriptions).as(Subscription.all)}
end
