class DollarizeExhibit < DisplayCase::Exhibit

  def self.applicable_to?(object)
    ['Order', 'OrderItem', 'Product'].include? object.class.name
  end

  def dollarize(cents)
    "$%.2f" % (cents / 100.0)
  end

end