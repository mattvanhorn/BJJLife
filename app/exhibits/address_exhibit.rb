class AddressExhibit < DisplayCase::Exhibit
  def self.applicable_to?(object)
    object.class.name == 'Address'
  end

  def to_html
    [street_address, city_state_zip].deblankify.join('<br/>').html_safe
  end

  private

  def street_address
    [street, unit].deblankify.clean_join(', ')
  end

  def city_state_zip
    "#{[city, us_state].deblankify.clean_join(', ')} #{postal_code}".strip
  end

end