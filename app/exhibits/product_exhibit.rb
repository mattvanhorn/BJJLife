require_relative '../helpers/exhibit_helper'

class ProductExhibit < DisplayCase::Exhibit
  include ExhibitHelper

  def self.applicable_to?(object)
    object.class.name == 'Product'
  end

  def price
    dollarize super
  end

  # TODO: refactor into DisplayCase
  def eql?(other)
    (self.class == other.class) && (self.to_model == other.to_model)
  end
  alias :== eql?
end