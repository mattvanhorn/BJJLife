class AcademyDecorator < Draper::Base
  decorates :academy

  def address
    street, unit, city, us_state, postal_code = academy.street, academy.unit, academy.city, academy.us_state, academy.postal_code
    street_line = [street, unit].collect(&:presence).compact.join(', ').strip
    region_line = [[city, us_state].collect(&:presence).compact.join(', '), postal_code].collect(&:presence).compact.join(' ').strip
    address = [street_line, region_line].collect(&:presence).compact
  end

  def contact
    email, website, phone_number = academy.email, academy.website, academy.phone_number
    website = h.link_to(website, website) if website
    phone_number = phone_number
    email = h.mail_to email, email if email
    [website, phone_number, email].reject{ |item| item.blank? }
  end

end