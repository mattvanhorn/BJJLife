class AddressExhibit < DisplayCase::BasicExhibit
  include ExhibitBaseHelper

  def self.applicable_to?(object, context)
    object.class.name == 'Address'
  end

  def street_address
    [street, unit].deblankify.clean_join(', ').presence
  end

  def city_state_zip
    "#{[city, us_state].deblankify.clean_join(', ')} #{postal_code}".strip.presence
  end

  def to_s
    [street_address, city_state_zip].compact.join(', ')
  end
end