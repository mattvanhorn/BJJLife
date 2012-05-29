require 'spec_helper'

describe Post do
  subject { Post.new }

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
