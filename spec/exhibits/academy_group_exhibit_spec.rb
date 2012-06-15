require 'display_case'
require_relative '../../app/exhibits/academy_group_exhibit'

describe AcademyGroupExhibit do
  let(:context)  { Object.new }
  let(:academy_group) { Object.new }
  let(:exhibit)  { AcademyGroupExhibit.new(academy_group, context) }

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
