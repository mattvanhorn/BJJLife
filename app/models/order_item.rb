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

class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  before_validation :set_price
  before_create :generate_redemption_codes

  def product_name
    product.name if product
  end

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
