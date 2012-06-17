class ContactInfoExhibit < DisplayCase::Exhibit
  def self.applicable_to?(object)
    object.class.name == 'ContactInfo'
  end

  def website_link
    in_view.link_to(website, website) if website
  end

  def email_link
    in_view.mail_to(email, email) if email
  end

  def phone_link
    in_view.link_to(phone_number, "tel://#{phone_number}") if phone_number
  end

  def links(separator = "\n<br/>\n")
    [website_link, phone_link, email_link].deblankify.join(separator).html_safe
  end

  private

  def in_view
    @context.respond_to?(:view_context) ? @context.view_context : @context
  end


end