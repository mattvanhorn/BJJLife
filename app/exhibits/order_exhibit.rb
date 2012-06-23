require_relative '../helpers/exhibit_helper'

class OrderExhibit < BaseExhibit
  include ExhibitHelper

  def self.applicable_to?(object)
    object.class.name == 'Order'
  end

  exhibit_query :item

  def amount
    dollarize super
  end

end
