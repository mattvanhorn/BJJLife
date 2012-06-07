class AcademyDecorator < Draper::Base
  decorates :academy

  def address
    address = [street_address, city_state_zip].deblankify
  end

  def contact
    _website = h.link_to(website, website) if website
    _email = h.mail_to(email, email) if email
    [_website, phone_number, _email].deblankify
  end

  private

  def street_address
    [street, unit].deblankify.clean_join(', ')
  end

  def city_state_zip
    "#{[city, us_state].deblankify.clean_join(', ')} #{postal_code}".strip
  end
end