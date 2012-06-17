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

class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates_presence_of :order_id, :product_id, :quantity, :unit_price, :price

  before_validation :set_price
  before_create :generate_redemption_codes

  delegate :name, :to => :product, :prefix => true, :allow_nil => true

  def subtotal
    quantity * unit_price
  end

  def adjusted_subtotal
    price || (subtotal - adjustment)
  end

  def redemption_codes
    @_redemption_codes || []
  end

  private

  def set_price
    self.price ||= adjusted_subtotal
  end

  def generate_redemption_codes
    @_redemption_codes ||= Array.new(quantity).map{RedemptionCode.new}
  end
end
