require 'display_case'
require 'ostruct'
require_relative '../../app/exhibits/comment_exhibit'

describe CommentExhibit do

  subject        { exhibit }

  let(:context)  { Object.new }
  let(:comment)  { Object.new }

  let(:exhibit)  { CommentExhibit.new(comment, context) }

  its(:haml_object_ref){ should == 'comment' }

end
