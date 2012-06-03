class CommentDecorator < Draper::Base
  decorates :comment

  def contributor
    comment.user.try(:username) || 'anonymous'
  end

  def haml_object_ref
    'comment'
  end
end