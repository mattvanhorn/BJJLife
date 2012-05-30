class ContactMethodValidator < ActiveModel::Validator
  def validate(record)
    unless record.website.present? || record.phone_number.present? || record.email.present?
      errors = record.errors
      errors.add :base, errors.generate_message(:base, :no_contact_method)
    end
  end
end