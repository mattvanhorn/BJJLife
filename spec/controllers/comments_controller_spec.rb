require 'spec_helper'

describe CommentsController do
  include NullDB::RSpec::NullifiedDatabase

  let(:current_user) { mock_model(User).as_null_object }
  let(:the_post) { mock_model(Post) }
  let(:comment) { mock_model(Comment, :post => the_post, :save! => true).as_null_object }

  before(:each) do
    controller.stub(:current_user => current_user)
    Comment.stub(:new => comment)
  end

  it "should not reek" do
    get_source_file(__FILE__).should_not reek
  end

  describe "#create" do
    it "saves the comment" do
      comment.should_receive(:save!).and_return(true)
      post :create
    end

    it "redirects to the post page" do
      post :create
      response.should redirect_to(post_path(the_post))
    end
  end

end
