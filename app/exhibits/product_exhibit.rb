require_relative '../helpers/exhibit_currency_helper'

class ProductExhibit < DisplayCase::Exhibit
  include ExhibitBaseHelper
  include ExhibitCurrencyHelper

  exhibit_query :category

  def self.applicable_to?(object)
    object.class.name == 'Product'
  end

  def price
    dollarize super
  end

  def thumbnail
    deliver_image(photo.thumb)
  end

  def category_class
    category.to_css_class
  end

  private

  def deliver_image(obj)
    return in_view.image_tag obj
  end

end
