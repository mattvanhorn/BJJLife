class CommentExhibit< DisplayCase::Exhibit

  def self.applicable_to?(object)
    object.class.name == 'Comment'
  end

  def haml_object_ref
    'comment'
  end
end