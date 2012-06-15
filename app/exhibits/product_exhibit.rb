require_relative '../helpers/exhibit_helper'

class ProductExhibit < DisplayCase::Exhibit
  include ExhibitHelper

  def self.applicable_to?(object)
    object.class.name == 'Product'
  end

  def price
    dollarize super
  end

end