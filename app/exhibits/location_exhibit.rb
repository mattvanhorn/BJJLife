class LocationExhibit < DisplayCase::Exhibit
  include ExhibitBaseHelper

  def self.applicable_to?(object, context)
    [Location, AcademyLocation].include? object.class
  end

  def to_s
    "#{city}, #{region || country}"
  end

  exhibit_query :address
end
