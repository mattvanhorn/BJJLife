require 'spec_helper'
require 'ostruct'

describe CommentsController do
  include NullDB::RSpec::NullifiedDatabase

  describe "#create" do
    let(:params)  { HashWithIndifferentAccess.new({:post_id => '42'}) }
    let(:comment) { OpenStruct.new(:post => the_post, :new_record? => true) }
    let(:comments){ [] }
    let(:the_post){ OpenStruct.new(:comments => comments) }
    let(:current_user){ OpenStruct.new(:to_model => Object.new) }

    before(:each) do
      controller.stub(:current_user => current_user, :locate_user => true)
      comments.stub(:new => comment)
      Post.stub(:find => the_post)
    end

    it "finds the post" do
      Post.should_receive(:find).and_return(the_post)
      post :create, params
    end

    it "creates a new comment" do
      comments.should_receive(:new).and_return(comment)
      post :create, params
    end

    it "assigns the user to the post" do
      comment.should_receive(:user=).with(current_user.to_model)
      post :create, params
    end

    it "saves the comment" do
      comment.should_receive(:save!).and_return(true)
      post :create, params
    end

    it "redirects to the post page" do
      post :create, params
      response.should redirect_to(post_path(the_post))
    end
  end

end
