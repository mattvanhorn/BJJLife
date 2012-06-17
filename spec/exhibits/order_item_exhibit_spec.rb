require 'display_case'
require_relative '../../spec/support/custom_matchers'
require_relative '../../app/exhibits/order_item_exhibit'

describe "OrderItemExhibit" do
  class OrderItem; end
  subject { OrderItemExhibit }
  it { should apply_to(OrderItem.new) }
end

describe OrderItemExhibit do
  let(:context){ Object.new }
  let(:item){ OpenStruct.new }
  let(:exhibit){ OrderItemExhibit.new(item, context) }

  describe "#unit_price" do
    it "formats the unit price with dollar sign and 2 decimals" do
      item.unit_price = 1000
      exhibit.unit_price.should == '$10.00'
    end
  end

  describe "#subtotal" do
    it "formats the subtotal with dollar sign and 2 decimals" do
      item.subtotal = 1234
      exhibit.subtotal.should == '$12.34'
    end
  end
end
