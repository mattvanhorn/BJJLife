require_relative '../helpers/exhibit_currency_helper'

class OrderItemExhibit < DisplayCase::Exhibit
  include ExhibitCurrencyHelper
  include ExhibitBaseHelper

  def self.applicable_to?(object, context)
    object.class.name == 'OrderItem'
  end

  def unit_price
    dollarize super
  end

  def subtotal
    dollarize super
  end

end
