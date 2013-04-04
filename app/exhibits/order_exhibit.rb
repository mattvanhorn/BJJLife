require_relative '../helpers/exhibit_currency_helper'

class OrderExhibit < DisplayCase::Exhibit
  include ExhibitCurrencyHelper
  include ExhibitBaseHelper

  def self.applicable_to?(object, context)
    object.class.name == 'Order'
  end

  exhibit_query :item

  def amount
    dollarize super
  end

end
