require 'spec_helper'

describe "Market constants", :db => true do
  let(:national)    { Market.create(:name => 'National') }
  let(:new_york)    { Market.create(:name => 'New York') }
  let(:los_angeles) { Market.create(:name => 'Los Angeles') }
  let(:chicago)     { Market.create(:name => 'Chicago') }

  before(:each) do
    national.children << new_york
    national.children << los_angeles
    national.children << chicago
  end

  it "it creates constants based on the contents of the database" do
    defined?(Market::NEW_YORK).should be_false
    defined?(Market::LOS_ANGELES).should be_false
    defined?(Market::CHICAGO).should be_false
    Market.create_constants
    Market::NEW_YORK.should == new_york
    Market::LOS_ANGELES.should == los_angeles
    Market::CHICAGO.should == chicago
  end
end
