class AcademyExhibit < DisplayCase::Exhibit

  def self.applicable_to?(object)
    object.class.name == 'Academy'
  end

  def address
    exhibit(__getobj__.address)
  end

  def contact_info
    exhibit(__getobj__.contact_info)
  end

end