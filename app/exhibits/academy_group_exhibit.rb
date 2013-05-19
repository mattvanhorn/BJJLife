class AcademyGroupExhibit < DisplayCase::Exhibit
  include ExhibitBaseHelper

  def self.applicable_to?(object, context)
    object.class.name == 'AcademyGroup'
  end

  exhibit_query :academies

  def render(template, css = '')
    template.render(partial: 'academy_groups/academy_group', locals: {academy_group: self, css: css})
  end

  def render_as_link(template)
    template.render(partial: 'academy_groups/academy_group_link', locals: {academy_group: self})
  end

end
