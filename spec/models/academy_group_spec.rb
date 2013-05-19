require_relative "../../app/models/academy_group"

describe AcademyGroup do

  let(:academies){ Object.new }

  subject(:academy_group) { AcademyGroup.new('NY', 'new_york', academies) }

  it "has a label" do
    academy_group.label.should == 'NY'
  end

  it "has an anchor" do
    academy_group.anchor.should == 'new_york'
  end

  it "has a group of academies" do
    academy_group.academies.should equal(academies)
  end

  it "is persisted if all the academies are saved" do
    academies = [stub(:persisted? => true)] * 5
    AcademyGroup.new('NY', 'new_york', academies).should be_persisted
  end

  it "is not persisted if any of the academies is unsaved" do
    academies = ([stub(:persisted? => true)] * 5) + [stub(:persisted? => false)]
    AcademyGroup.new('NY', 'new_york', academies).should_not be_persisted
  end

  it "has a cache key dependent on the academies and the state" do
    academies = [stub(:cache_key => '123')]
    AcademyGroup.new('NY', 'new_york', academies).cache_key.should == ['123','NY', 'new_york'].hash
  end

end
