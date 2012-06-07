class ContactInfo
  attr_reader :email, :phone_number, :website

  def initialize(email, phone_number, website)
    @email, @phone_number, @website = email, phone_number, website
  end
end