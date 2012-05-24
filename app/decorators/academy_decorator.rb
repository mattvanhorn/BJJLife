class AcademyDecorator < Draper::Base
  decorates :academy

  def address
    line1 = [academy.street, academy.unit].join(', ').strip
    line2 = [[academy.city, academy.us_state].join(', '), academy.postal_code].join(' ').strip
    address = [line1, line2].reject{ |l| l.blank? }
  end

  def contact
    line1 = h.link_to(academy.website, academy.website) if academy.website
    line2 = academy.phone_number
    line3 = h.mail_to academy.email, academy.email if academy.email
    [line1, line2, line3].reject{ |l| l.blank? }
  end

end