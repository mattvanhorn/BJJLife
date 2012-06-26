require 'spec_helper'

describe PostsController do
  include NullDB::RSpec::NullifiedDatabase

  let(:current_user) { double(:id => '123', :model => true) }
  let(:comment) { stub }
  let(:the_post){ mock_model(Post, :publish! => true, :new_comment => comment) }
  let(:entries) { double('entries', :new => the_post).as_null_object }
  let(:blog)    { mock_model(Blog, :entries => entries) }

  before(:each) do
    controller.stub(:current_user => current_user, :locate_user => true)
    Blog.stub(:first => blog)
    the_post.stub(:blog => blog, :blog_name => 'Training')
  end

  it "should not reek" do
    get_source_file(__FILE__).should_not reek
  end

  describe "#new" do
    it "requires sign in" do
      controller.stub(:user_signed_in? => false)
      get :new
      response.should redirect_to(sign_in_path)
    end

    it "exhibits the blog and post" do
      controller.should_receive(:exhibit_exposed).with(:blog, :post)
      get :new
    end
  end

  describe "#create" do
    it "requires sign in" do
      controller.stub(:user_signed_in? => false)
      post :create
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

    it "exhibits the blog and posts/post" do
      controller.should_receive(:exhibit_exposed).with(:blog, :posts, :post)
      post :create
    end
  end

  describe "show" do
    before(:each) do
      entries.stub(:find => the_post)
    end
    it "does not require sign in" do
      controller.stub(:user_signed_in? => false)
      get :show, :id => '42'
      response.should be_success
    end

    it "finds the post" do
      entries.should_receive(:find).with('42').and_return(the_post)
      get :show, :id => '42'
    end

    it "exhibits the blog, post and comment" do
      controller.should_receive(:exhibit_exposed).with(:blog, :post, :comment)
      get :show, :id => '42'
    end

    it "renders the show template" do
      get :show, :id => '42'
      response.should render_template(:show)
    end
  end
end

