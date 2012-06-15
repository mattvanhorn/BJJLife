require 'display_case'
require_relative '../../app/exhibits/product_exhibit'

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
