require 'spec_helper'

class TestExhibit < DisplayCase::Exhibit
  include ExhibitBaseHelper
  def self.applicable_to?(object)
    true
  end
end

class TestModel
  def to_model
    self
  end
end

describe ExhibitBaseHelper do
  let(:context) { Object.new }
  let(:model){ TestModel.new }
  let(:exhibit){ TestExhibit.new(model, context)}
  it "is equal to it's model" do
    exhibit.should == model
  end
  
  it "is not equal to non-models" do
    obj = Object.new
    obj.should_not respond_to(:to_model)
    model.should_receive(:==).with(obj)
    exhibit.should_not == obj
  end
  
  it "is equal to it's model" do
    exhibit.should be_eql(model)
  end
  
  it "is not equal to non-models" do
    obj = Object.new
    obj.should_not respond_to(:to_model)
    model.should_receive(:eql?).with(obj)
    exhibit.should_not be_eql(obj)
  end
end
