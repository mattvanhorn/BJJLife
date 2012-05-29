require 'spec_helper'

describe Blog do

  let(:new_post) { OpenStruct.new }
  subject { Blog.new.tap{|b|b.post_source = ->{ new_post }} }

  it { should have(0).entries }

  describe "#new_post" do

    it "returns a new post" do
      subject.new_post.should equal new_post
    end

    it "sets the post's blog reference to itself" do
      subject.new_post.blog.should equal(subject)
    end

    it "accepts an attribute hash on behalf of the post maker" do
      post_source = mock('src')
      post_source.should_receive(:call).with(x: 42, y: 'z').and_return(new_post)
      subject.post_source = post_source
      subject.new_post(x: 42, y: 'z')
    end

  end

  describe "#add_entry" do
    it "adds to the entries collection" do
      entry = double('entry')
      subject.entries.should_receive(:<<).with(entry)
      subject.add_entry(entry)
    end
  end
end
