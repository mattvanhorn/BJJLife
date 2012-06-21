# == Schema Information
#
# Table name: posts
#
#  id          :integer         not null, primary key
#  blog_id     :integer
#  title       :string(255)
#  url         :string(255)
#  description :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  user_id     :integer
#  up_votes    :integer         default(0), not null
#  down_votes  :integer         default(0), not null
#
# Indexes
#
#  index_posts_on_blog_id  (blog_id)
#  index_posts_on_user_id  (user_id)
#

require 'spec_helper'

describe Post do
  include NullDB::RSpec::NullifiedDatabase

  let(:new_comment) { OpenStruct.new }
  subject { Post.new.tap{|p|p.comment_source = lambda{ new_comment }} }

  it "should not reek" do
    get_source_file(__FILE__).should_not reek
  end

  it "starts with no comments" do
    subject.comments.should be_empty
  end

  describe "#publish" do
    let(:blog) { mock_model(Blog) }

    before do
      subject.blog = blog
    end

    it "adds the post to the blog" do
      blog.should_receive(:add_entry).and_return [subject]
      subject.publish!
    end
  end

  describe "#new_comment" do
    it "returns a new post" do
      subject.new_comment.should == new_comment
    end
    it "sets the post's blog reference to itself" do
      subject.new_comment.post.should == subject
    end
  end
end
