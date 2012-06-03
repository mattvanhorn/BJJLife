require 'spec_helper'

describe PostsController do
  include NullDB::RSpec::NullifiedDatabase

  let(:current_user) { double(:id => '123', :model => true) }
  let(:the_post) { mock_model(Post, :publish! => true) }
  let(:blog) { mock_model(Blog, :new_post => the_post) }

  before(:each) do
    controller.stub(:current_user => current_user)
    Blog.stub(:first => blog)
    the_post.stub(:blog => blog)
  end

  it "should not reek" do
    File.open(__FILE__).should_not reek
  end

  it { should expose(:blog).as(Blog.first) }
  it { should expose(:post).as(blog.new_post) }

  describe "#new" do
    it "requires sign in" do
      controller.stub(:user_signed_in? => false)
      get :new
      response.should redirect_to(sign_in_path)
    end
  end

  describe "#create" do
    it "requires sign in" do
      controller.stub(:user_signed_in? => false)
      get :new
      response.should redirect_to(sign_in_path)
    end

    it "publishes the post" do
      the_post.should_receive(:publish!)
      post :create
    end

    it "redirects to the blog page" do
      post :create
      response.should redirect_to(blog_path(blog))
    end
  end

  describe "show" do
    it "does not require sign in" do
      controller.stub(:user_signed_in? => false)
      get :show
      response.should be_success
    end

    it "renders the show template" do
      get :show
      response.should render_template(:show)
    end
  end
end

