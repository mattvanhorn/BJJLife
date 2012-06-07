require 'spec_helper'

describe AcademyGroupExhibit do
  let(:academy_group){ double('group') }
  let(:exhibit) { AcademyGroupExhibit.new(academy_group, self) }

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
