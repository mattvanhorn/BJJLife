class ContactMethodValidator < ActiveModel::Validator
  def validate(record)
    unless record.website.present? || record.phone_number.present? || record.email.present?
      record.errors.add :base, record.errors.generate_message(:base, :no_contact_method)
    end
  end
end