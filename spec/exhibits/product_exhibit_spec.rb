require 'exhibit_spec_helper'
require_relative '../../app/exhibits/product_exhibit'

describe "ProductExhibit" do
  stub_class 'Product'
  subject { ProductExhibit }
  it { should apply_to(Product.new) }
end

describe ProductExhibit do
  Delegator.class_eval { include RSpec::Mocks::Methods }

  let(:context) { Object.new }
  let(:category){ Object.new }
  let(:product) { OpenStruct.new(:category => category, :photo => OpenStruct.new(:thumb => 'thumb')) }
  let(:exhibit) { ProductExhibit.new(product, context) }

  describe "#price" do
    it "formats the unit price with dollar sign and 2 decimals" do
      product.price = 1000
      exhibit.stub(:to_model => product)
      exhibit.price.should == '$10.00'
    end
  end

  describe "#category_class" do
    let(:exhibited_category){ OpenStruct.new(:to_css_class => 'foo') }

    it "delegates to the category" do
      exhibit.should_receive(:exhibit).with(category).and_return(exhibited_category)
      exhibit.category_class.should == 'foo'
    end
  end

  describe "#thumbnail" do
    it "should emit a thumbnail image tag" do
      context.should_receive(:image_tag).with('thumb').and_return('<img src="thumb"/>')
      exhibit.thumbnail.should == '<img src="thumb"/>'
    end
  end
end
