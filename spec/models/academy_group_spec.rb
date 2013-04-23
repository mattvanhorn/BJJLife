require_relative "../../app/models/academy_group"

describe AcademyGroup do

  let(:academies){ Object.new }

  subject { AcademyGroup.new('NY', academies) }

  it "has a US state" do
    subject.us_state.should == 'NY'
  end

  it "has a region" do
    subject.region.should == 'NY'
  end

  it "has a group of academies" do
    subject.academies.should equal(academies)
  end

  it "is persisted if all the academies are saved" do
    academies = [stub(:persisted? => true)] * 5
    AcademyGroup.new('NY', academies).should be_persisted
  end

  it "is not persisted if any of the academies is unsaved" do
    academies = ([stub(:persisted? => true)] * 5) + [stub(:persisted? => false)]
    AcademyGroup.new('NY', academies).should_not be_persisted
  end

  it "has a cache key dependent on the academies and the state" do
    academies = [stub(:cache_key => '123')]
    AcademyGroup.new('NY', academies).cache_key.should == ['123','NY'].hash
  end

end
