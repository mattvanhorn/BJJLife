require 'exhibit_spec_helper'
require_relative '../../app/exhibits/academy_group_exhibit'

describe "AcademyGroupExhibit" do
  let(:fake_class){ double('klass', :name => 'AcademyGroup') }

  subject { AcademyGroupExhibit }

  before(:each) do
    stub_const("AcademyGroup", fake_class)
    AcademyGroup.stub(:new).and_return(double('AcademyGroup', :class => fake_class))
  end

  it { should apply_to(AcademyGroup.new('NY', [])) }
end

describe AcademyGroupExhibit do
  Delegator.class_eval { include RSpec::Mocks::Methods }

  subject(:exhibit){ AcademyGroupExhibit.new(academy_group, context) }

  let(:context)       { Object.new }
  let(:academy_group) { OpenStruct.new(:academies => academies) }
  let(:academies)     { Object.new }

  describe "academies" do
    it 'exhibits its academies' do
      exhibited_academies = Object.new
      exhibit.should_receive(:exhibit).with(academies).and_return(exhibited_academies)
      exhibit.academies.should equal(exhibited_academies)
    end
  end

  describe "#full_us_state_name" do
    it "converts known abbreviations" do
      academy_group.stub(:us_state => 'NY')
      exhibit.full_us_state_name.should == 'New York'
      academy_group.stub(:us_state => 'CA')
      exhibit.full_us_state_name.should == 'California'
    end

    it "handles lowercase abbreviations" do
      academy_group.stub(:us_state => 'ak')
      exhibit.full_us_state_name.should == 'Alaska'
    end

    it "returns the argument if unknown" do
      academy_group.stub(:us_state => 'Foo')
      exhibit.full_us_state_name.should == 'Foo'
    end
  end
end
