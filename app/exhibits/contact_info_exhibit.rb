class ContactInfoExhibit < DisplayCase::Exhibit
  def self.applicable_to?(object)
    object.class.name == 'ContactInfo'
  end

  def to_html(template)
    [website_link(template), phone_number, email_link(template)].deblankify.join('<br/>').html_safe
  end

  def website_link(template)
    template.link_to(website, website) if website
  end

  def email_link(template)
    template.mail_to(email, email) if email
  end

end