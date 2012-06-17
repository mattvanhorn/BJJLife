require 'display_case'
require 'ostruct'
require_relative '../../spec/support/custom_matchers'
require_relative '../../app/exhibits/comment_exhibit'

describe "CommentExhibit" do
  class Comment; end
  subject { CommentExhibit }
  it { should apply_to(Comment.new) }
end

describe CommentExhibit do

  subject        { exhibit }

  let(:context)  { Object.new }
  let(:comment)  { Object.new }

  let(:exhibit)  { CommentExhibit.new(comment, context) }

  its(:haml_object_ref){ should == 'comment' }

end
