class LocationExhibit < DisplayCase::Exhibit
  include ExhibitBaseHelper

  def self.applicable_to?(object)
    object_is_any_of?(object, Location, AcademyLocation)
  end

  exhibit_query :address
end