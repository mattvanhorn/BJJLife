class LocationValidator < ActiveModel::Validator
  def validate(record)
    unless (record.city.present? && record.us_state.present?) || record.postal_code.present?
      record.errors.add :base, record.errors.generate_message(:base, :no_location)
    end
  end
end

