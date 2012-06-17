require 'exhibit_spec_helper'
require_relative '../../app/exhibits/post_exhibit'

describe "PostExhibit" do
  stub_class 'Post'
  subject { PostExhibit }
  it { should apply_to(Post.new) }
end

describe PostExhibit do
  Delegator.class_eval { include RSpec::Mocks::Methods }

  subject        { exhibit }

  let(:context)  { Object.new }
  let(:blog)     { Object.new }
  let(:post)     { OpenStruct.new(:comments => comments, :blog => blog) }
  let(:comments) { Object.new }

  let(:exhibit)  { PostExhibit.new(post, context) }

  it 'exhibits its comments' do
    exhibited_comments = Object.new
    exhibit.should_receive(:exhibit).with(comments).and_return(exhibited_comments)
    exhibit.comments.should equal(exhibited_comments)
  end

  it 'has a blog_name' do
    blog.stub(:title => 'foobar')
    exhibit.blog_name.should == 'foobar'
  end

  its(:haml_object_ref){ should == 'post' }
end
