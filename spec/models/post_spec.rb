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
#

require 'spec_helper'

describe Post do
  subject { Post.new }

  it "should not reek" do
    File.open(__FILE__).should_not reek
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
end
