require_relative '../helpers/exhibit_helper'

class ProductExhibit < DisplayCase::Exhibit
  include ExhibitHelper

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

  # TODO: refactor into DisplayCase
  def eql?(other)
    (self.class == other.class) && (self.to_model == other.to_model)
  end
  alias :== eql?

  private

  def deliver_image(obj)
    return in_view.image_tag obj
  end

  def in_view
    @context.respond_to?(:view_context) ? @context.view_context : @context
  end
end
