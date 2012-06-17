# == Schema Information
#
# Table name: order_items
#
#  id         :integer         not null, primary key
#  order_id   :integer         not null
#  product_id :integer         not null
#  quantity   :integer         default(1), not null
#  unit_price :integer         not null
#  adjustment :integer         default(0), not null
#  price      :integer         not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
# Indexes
#
#  index_order_items_on_order_id    (order_id)
#  index_order_items_on_product_id  (product_id)
#

require 'spec_helper'

describe OrderItem do
  include NullDB::RSpec::NullifiedDatabase

  let(:order){ mock_model(Order) }
  let(:product){mock_model(Product, :price => 1000, :name => 'Rocketskates')}
  let(:item){ OrderItem.new }

  subject { item }

  before do
    item.order = order
    item.product = product
    item.quantity = 2
    item.unit_price = 1000
    item.adjustment = 200
  end

  it "should not reek" do
    get_source_file(__FILE__).should_not reek
  end

  describe "validations" do
    before(:each) do
      item.stub(:set_price) # otherwise the before_validation prevents the error
    end
    it { should validate_presence_of(:order_id) }
    it { should validate_presence_of(:product_id) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:price) }
  end

  its(:product_name){ should == 'Rocketskates' }
  its(:subtotal){ should == 2000 }
  its(:adjusted_subtotal){ should == 1800 }

  it "overrides the adjusted subtotal with the persisted price if one exists" do
    item.price = 1500
    item.adjusted_subtotal.should == 1500
  end

  it "calcuates a price before validating" do
    item.price.should be_nil
    item.valid?
    item.price.should == 1800
  end

  context "when it is new" do
    it { should have(0).redemption_codes }
  end

  context "when it is saved" do
    before do
      item.save
    end
    it { should have(2).redemption_codes }
  end


end
