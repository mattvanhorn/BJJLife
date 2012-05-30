class AcademyDecorator < Draper::Base
  decorates :academy

  def address
    street, unit, city, us_state, postal_code = academy.street, academy.unit, academy.city, academy.us_state, academy.postal_code
    street_line = comma_join [street, unit]
    region_line = space_join [comma_join([city, us_state]), postal_code]
    address = deblankify [street_line, region_line]
  end

  def contact
    email, website, phone_number = academy.email, academy.website, academy.phone_number
    website = h.link_to(website, website) if website
    phone_number = phone_number
    email = h.mail_to email, email if email
    deblankify [website, phone_number, email]
  end

  private

  def comma_join(arr)
    deblankify_with_clean_join(arr, ', ')
  end

  def space_join(arr)
    deblankify_with_clean_join(arr, ' ')
  end

  def deblankify_with_clean_join(arr, delimiter)
    deblankify(arr).join(delimiter).strip
  end

  def deblankify(arr)
    arr.collect(&:presence).compact
  end
end