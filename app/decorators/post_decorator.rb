class PostDecorator < Draper::Base
  decorates :post

  def contributor
    post.user.try(:username) || 'anonymous'
  end

  def blog_name
    blog.title
  end

  def haml_object_ref
    'post'
  end
end