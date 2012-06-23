class BlogExhibit < BaseExhibit

  def self.applicable_to?(object)
    object.class.name == 'Blog'
  end

  exhibit_query :entries

end