require 'spec_helper'

describe Admin::SubscriptionsController do
  before(:each) do
    Subscription.stub(:all => [double('sub')])
  end
  
  it { should expose(:subscriptions).as(Subscription.all)}
end
