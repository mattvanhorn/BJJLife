class ContactMethodValidator < ActiveModel::Validator
  def validate(record)
    unless record.website || record.phone_number || record.email
      record.errors.add :base, record.errors.generate_message(:base, :no_contact_method)
    end
  end
end