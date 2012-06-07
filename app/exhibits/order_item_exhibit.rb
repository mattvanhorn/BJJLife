class OrderItemExhibit< DisplayCase::Exhibit

  def self.applicable_to?(object)
    object.class.name == 'OrderItem'
  end

  def unit_price
    dollarize order_item.unit_price
  end

  def subtotal
    dollarize order_item.subtotal
  end


end
