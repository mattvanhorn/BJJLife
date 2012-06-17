require 'display_case'
require_relative '../../spec/support/custom_matchers'
require_relative '../../app/exhibits/product_exhibit'

describe "ProductExhibit" do
  class Product; end
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
end
