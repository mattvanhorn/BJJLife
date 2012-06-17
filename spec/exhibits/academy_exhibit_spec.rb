require 'exhibit_spec_helper'
require_relative '../../app/exhibits/academy_exhibit'

describe "AcademyExhibit" do
  stub_class 'Academy'
  before { Academy.stub(:new => double(:class => Academy)) }
  subject { AcademyExhibit }
  it { should apply_to(Academy.new) }
end

describe AcademyExhibit do
  Delegator.class_eval { include RSpec::Mocks::Methods }

  subject        { exhibit }

  let(:context) { Object.new }
  let(:address) { Object.new }
  let(:contact) { Object.new }
  let(:academy) { OpenStruct.new(:address => address, :contact_info => contact) }

  let(:exhibit)  { AcademyExhibit.new(academy, context) }

  it 'exhibits its address' do
    exhibited_address = Object.new
    exhibit.should_receive(:exhibit).with(address).and_return(exhibited_address)
    exhibit.address.should equal(exhibited_address)
  end

  it 'exhibits its contact info' do
    exhibited_contact = Object.new
    exhibit.should_receive(:exhibit).with(contact).and_return(exhibited_contact)
    exhibit.contact_info.should equal(exhibited_contact)
  end

end
