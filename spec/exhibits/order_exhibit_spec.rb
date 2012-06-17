require 'exhibit_spec_helper'
require_relative '../../app/exhibits/order_exhibit'

describe "OrderExhibit" do
  stub_class 'Order'
  subject { OrderExhibit }
  it { should apply_to(Order.new) }
end

describe OrderExhibit do
  Delegator.class_eval { include RSpec::Mocks::Methods }

  let(:context) { Object.new }
  let(:order)   { OpenStruct.new(:item => item) }
  let(:item)    { Object.new }
  let(:exhibit) { OrderExhibit.new(order, context) }

  describe "#amount" do
    it "formats the amount with dollar sign and 2 decimals" do
      order.amount = 1000
      exhibit.stub(:to_model => order)
      exhibit.amount.should == '$10.00'
    end
  end

  it 'exhibits its item' do
    exhibited_item = Object.new
    exhibit.should_receive(:exhibit).with(item).and_return(exhibited_item)
    exhibit.item.should equal(exhibited_item)
  end
end
