class AcademyExhibit < DisplayCase::Exhibit

  def self.applicable_to?(object)
    object.class.name == 'Academy'
  end

  exhibit_query :address, :contact_info

end