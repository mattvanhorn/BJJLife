require 'spec_helper'

class TestExhibit < DisplayCase::Exhibit
  include ExhibitBaseHelper
  def self.applicable_to?(object, context)
    true
  end
end

class TestModel
  def to_model
    self
  end
end

class OtherModel
  def to_model
    self
  end
end

describe ExhibitBaseHelper do
  let(:context) { Object.new }
  let(:model){ TestModel.new }
  let(:other_model){ OtherModel.new }
  let(:exhibit){ TestExhibit.new(model, context)}

  it "is equal to it's model" do
    #note There is some strangeness around testing these methods
    # using `should ==` doesn't seem to exercise the right code
    (exhibit == model).should be_true
    exhibit.eql?(model).should be_true
  end

  it "is not equal to a different model" do
    #note There is some strangeness around testing these methods
    # using `should ==` doesn't seem to exercise the right code
    (exhibit == other_model).should be_false
    exhibit.eql?(other_model).should be_false
  end

  it "is not equal to other things" do
    obj = Object.new
    obj.should_not respond_to(:to_model)
    (exhibit == obj).should be_false
    exhibit.eql?(obj).should be_false
  end

end
