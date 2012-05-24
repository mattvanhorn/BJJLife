class LocationValidator < ActiveModel::Validator
  def validate(record)
    unless (record.city && record.us_state) || record.postal_code
      record.errors.add :base, record.errors.generate_message(:base, :no_location)
    end
  end
end

