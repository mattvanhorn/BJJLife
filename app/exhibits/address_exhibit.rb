class AddressExhibit < DisplayCase::Exhibit
  def self.applicable_to?(object)
    object.class.name == 'Address'
  end

  def street_address
    [street, unit].deblankify.clean_join(', ').presence
  end

  def city_state_zip
    "#{[city, us_state].deblankify.clean_join(', ')} #{postal_code}".strip.presence
  end

end