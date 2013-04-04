class BlogExhibit < DisplayCase::Exhibit
  include ExhibitBaseHelper

  def self.applicable_to?(object, context)
    object.class.name == 'Blog'
  end

  exhibit_query :entries

end
