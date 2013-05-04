class ContactMethodValidator < CustomValidator
  def validate(obj)
    super
    add_contact_method_errors unless has_contact_method?
  end

  def has_contact_method?
    @record.website.present? || @record.phone_number.present? || @record.email.present?
  end

  def add_contact_method_errors
    @errors.add :base, @errors.generate_message(:base, :no_contact_method)
  end

end
