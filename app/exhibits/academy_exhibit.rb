class AcademyExhibit < DisplayCase::Exhibit
  include ExhibitBaseHelper

  def self.applicable_to?(object, context)
    object.class.name == 'Academy'
  end

  def render_as_list_item(template)
    template.render(partial: 'academies/academy', locals: {academy: self})
  end

  exhibit_query :address, :location, :contact_info

end
