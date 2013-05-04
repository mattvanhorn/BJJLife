class LocationValidator < CustomValidator
  def validate(obj)
    super
    add_location_errors unless has_minimal_location?
  end

  def has_minimal_location?
    (@record.city.present? && @record.us_state.present?) || @record.postal_code.present?
  end

  def add_location_errors
    @errors.add :base, @errors.generate_message(:base, :no_location)
  end

end

