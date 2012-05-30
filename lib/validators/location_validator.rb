class LocationValidator < ActiveModel::Validator
  def validate(record)
    unless (record.city.present? && record.us_state.present?) || record.postal_code.present?
      errors = record.errors
      errors.add :base, errors.generate_message(:base, :no_location)
    end
  end
end

