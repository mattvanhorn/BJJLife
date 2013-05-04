require 'exhibit_spec_helper'
require_relative '../../app/exhibits/location_exhibit'

describe "LocationExhibit" do
  Delegator.class_eval { include RSpec::Mocks::Methods }
  stub_class 'Location'
  stub_class 'AcademyLocation'

  before { AcademyLocation.stub(:new => double(:class => AcademyLocation)) }
  subject { LocationExhibit }
  it { should apply_to Location.new }
  it { should apply_to AcademyLocation.new }
end

describe LocationExhibit do
  Delegator.class_eval { include RSpec::Mocks::Methods }

  subject { exhibit }

  let(:context) { Object.new }
  let(:address) { Object.new }
  let(:location) { OpenStruct.new(:address => address, :city => 'New York', :region => 'NY') }

  let(:exhibit)  { LocationExhibit.new(location, context) }

  it 'exhibits its address' do
    exhibited_address = Object.new
    exhibit.should_receive(:exhibit).with(address).and_return(exhibited_address)
    exhibit.address.should equal(exhibited_address)
  end

  it 'represents as a city, state string' do
    exhibit.to_s.should == 'New York, NY'
  end

end
