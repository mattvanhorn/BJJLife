class BlogExhibit< DisplayCase::Exhibit

  def self.applicable_to?(object)
    object.class.name == 'Blog'
  end

  def entries
    exhibit(__getobj__.entries)
  end

end