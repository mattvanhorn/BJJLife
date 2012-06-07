class Address
  attr_reader :street, :unit, :city, :us_state, :postal_code

  def initialize(street, unit, city, us_state, postal_code)
    @street, @unit, @city, @us_state, @postal_code = street, unit, city, us_state, postal_code
  end

end

