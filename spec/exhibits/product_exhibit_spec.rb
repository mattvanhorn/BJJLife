require 'exhibit_spec_helper'
require_relative '../../app/exhibits/product_exhibit'

describe "ProductExhibit" do
  stub_class 'Product'
  subject { ProductExhibit }
  it { should apply_to(Product.new) }
end

describe ProductExhibit do
  let(:context){ Object.new }
  let(:product){ OpenStruct.new }
  let(:exhibit){ ProductExhibit.new(product, context) }

  describe "#price" do
    it "formats the unit price with dollar sign and 2 decimals" do
      product.price = 1000
      exhibit.stub(:to_model => product)
      exhibit.price.should == '$10.00'
    end
  end

  describe "#category_class" do
    let(:category){ OpenStruct.new(:to_css_class => 'foo') }
    it "delegates to the category" do
      stub_module 'Rails' # DisplayCase has an unfortunate dependency on Rails.logger
      Rails.stub(:logger).and_return(stub.as_null_object)
      product.category = category
      exhibit.category_class.should == 'foo'
    end
  end
end
