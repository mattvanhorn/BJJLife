class PostExhibit< DisplayCase::Exhibit

  def self.applicable_to?(object)
    object.class.name == 'Post'
  end

  exhibit_query :comments

  def blog_name
    blog.title
  end

  def haml_object_ref
    'post'
  end
end

