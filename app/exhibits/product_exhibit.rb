class ProductExhibit < DisplayCase::Exhibit

  def self.applicable_to?(object)
    object.class.name == 'Product'
  end

  def price
    dollarize(self.to_model.price)
  end

end