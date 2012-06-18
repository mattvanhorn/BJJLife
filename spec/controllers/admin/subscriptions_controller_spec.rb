require 'spec_helper'

describe Admin::SubscriptionsController do
  include NullDB::RSpec::NullifiedDatabase
  include AuthHelper

  before(:each) do
    Subscription.stub(:all => [double('sub')])
  end

  it "should not reek" do
    get_source_file(__FILE__).should_not reek
  end
end
