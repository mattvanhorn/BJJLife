require 'exhibit_spec_helper'
require_relative '../../app/exhibits/category_exhibit'

describe "CategoryExhibit" do
  stub_class 'Category'
  subject { CategoryExhibit }
  it { should apply_to(Category.new) }
  it { should apply_to(nil) }
end

describe CategoryExhibit do
  let(:context){ Object.new }
  let(:category){ OpenStruct.new(:to_model => lambda{self}) }
  let(:exhibit){ CategoryExhibit.new(category, context) }

  describe "#name" do
    it "uses the category name if there is a category" do
      category.name = 'foo'
      exhibit.name.should == 'foo'
    end

    it "has an empty string for nil categories" do
      CategoryExhibit.new(DisplayCase::Exhibit::Exhibited.new(nil, self), context).name.should == ''
    end
  end

  describe "#to_css_class" do
    it "uses the category name" do
      category.name = 'foo'
      exhibit.to_css_class.should == 'foo'
    end

    it "replaces spaces and symbols with a dash" do
      category.name = 'foo bar//baz'
      exhibit.to_css_class.should == 'foo-bar-baz'
    end
  end

  describe "#nil?" do
    let(:wrapped_obj){ DisplayCase::Exhibit::Exhibited.new(Category.new, context) }
    let(:wrapped_nil){ DisplayCase::Exhibit::Exhibited.new(nil, context) }
    it "is true when its model is nil" do
      CategoryExhibit.new(wrapped_nil, context).nil?.should be_true
    end

    it "is false when its model is not nil" do
      CategoryExhibit.new(wrapped_obj, context).nil?.should be_false
    end
  end

  describe "#to_s" do
    it "represents the category as its name" do
      category.name = 'foo'
      exhibit.to_s.should == 'foo'
    end
  end
end
