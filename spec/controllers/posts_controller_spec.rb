require 'spec_helper'

describe PostsController do
  include NullDB::RSpec::NullifiedDatabase

  let(:the_post) { mock_model(Post, :publish! => true) }
  let(:blog) { mock_model(Blog, :new_post => the_post) }

  before(:each) do
    Blog.stub(:first => blog)
    the_post.stub(:blog => blog)
  end

  it "should not reek" do
    File.open(__FILE__).should_not reek
  end

  it { should expose(:blog).as(Blog.first) }
  it { should expose(:post).as(blog.new_post) }

  describe "#create" do
    it "publishes the post" do
      the_post.should_receive(:publish!)
      post :create
    end

    it "redirects to the blog page" do
      post :create
      response.should redirect_to(blog_path(blog))
    end
  end
end

