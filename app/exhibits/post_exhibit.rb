class PostExhibit< DisplayCase::Exhibit
  include ExhibitBaseHelper

  def self.applicable_to?(object, context)
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

