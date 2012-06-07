class PostExhibit< DisplayCase::Exhibit

  def self.applicable_to?(object)
    object.class.name == 'Post'
  end

  def comments
    exhibit(__getobj__.comments)
  end

  def blog_name
    blog.title
  end

  def haml_object_ref
    'post'
  end
end