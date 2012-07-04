require 'spec_helper'

describe BlogsController do
  let(:blog){ Object.new }


  it "exposes a blog" do
    Blog.should_receive(:first).and_return(blog)
    controller.blog.should equal(blog)
  end

  describe "#show" do

    it "exhibits a blog" do
      controller.should_receive(:exhibit_exposed).with(:blog)
      get :show, :id => 1
    end

    it "renders the right view" do
      get :show, :id => 1
      response.should render_template(:show)
    end
  end
end
