require 'spec_helper.rb'

describe AcademyGroup do

  let(:academies){ Object.new }

  subject { AcademyGroup.new('NY', academies) }


  it "has a US state" do
    subject.us_state.should == 'NY'
  end

  it "has a group of academies" do
    subject.academies.should equal(academies)
  end
end
