class AcademyExhibit < DisplayCase::Exhibit
  include ExhibitBaseHelper

  def self.applicable_to?(object, context)
    object.class.name == 'Academy'
  end

  exhibit_query :address, :location, :contact_info

end
