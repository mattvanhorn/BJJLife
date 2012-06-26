require 'spec_helper'

describe AcademyLocation do
  include NullDB::RSpec::NullifiedDatabase

  before(:each) do
    Geocoder.stub(:search => [])
  end

  subject { AcademyLocation.new }

  it "should not reek" do
    get_source_file(__FILE__).should_not reek
  end

  it { should validate_with LocationValidator }
  it { should ensure_length_of(:us_state).is_equal_to(2) }

end
