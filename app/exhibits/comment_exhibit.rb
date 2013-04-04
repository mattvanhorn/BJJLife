class CommentExhibit< DisplayCase::Exhibit
  include ExhibitBaseHelper

  def self.applicable_to?(object, context)
    object.class.name == 'Comment'
  end

  def haml_object_ref
    'comment'
  end
end
