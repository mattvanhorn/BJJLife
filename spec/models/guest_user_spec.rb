require 'spec_helper'

describe GuestUser do
  include NullDB::RSpec::NullifiedDatabase

  it "has an id" do
    GuestUser.new(1234).id.should == 1234
  end
end
