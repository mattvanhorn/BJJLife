class ContactInfoExhibit < DisplayCase::Exhibit
  include ExhibitBaseHelper

  def self.applicable_to?(object, context)
    object.class.name == 'ContactInfo'
  end

  def website_link
    WebsiteLink.new(website).render(in_view)
  end

  def email_link
    EmailLink.new(email).render(in_view)
  end

  def phone_link
    PhoneLink.new(phone_number).render(in_view)
  end

  def links(separator = "\n<br/>\n")
    [website_link, phone_link, email_link].deblankify.join(separator).html_safe
  end

  private

  class WebsiteLink
    attr_reader :name, :url

    def initialize(name)
      @name = name
      @url = name
    end

    def link_type
      :link_to
    end

    def render(context)
      context.send(link_type, name, url) unless blank?
    end

    def blank?
      name.blank?
    end
  end

  class PhoneLink < WebsiteLink
    def initialize(name)
      @name = name
      @url  = "tel://#{name}"
    end
  end

  class EmailLink < WebsiteLink
    def link_type
      :mail_to
    end
  end

end
