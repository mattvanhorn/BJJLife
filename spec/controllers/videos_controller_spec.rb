require 'spec_helper'

describe VideosController do
  include NullDB::RSpec::NullifiedDatabase

  let(:current_user) { double(:id => '123', :model => true) }
  let(:video) { mock_model(Video, :publish! => true) }
  let(:videos) { [video] }

  before(:each) do
    controller.stub(:current_user => current_user)
    controller.stub(:videos => videos)
    controller.stub(:video => video)
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

    it "renders the correct template" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "#create" do

    it "requires sign in" do
      controller.stub(:user_signed_in? => false)
      post :create
      response.should redirect_to(sign_in_path)
    end

    describe "with valid params" do
      let(:valid_params){ {'foo' => 'bar'} }

      it "creates a pending video" do
        video.should_receive(:publish!).and_return(true)
        post :create, :video => valid_params
      end

      it "redirects to the list page" do
        post :create, :video => valid_params
        response.should redirect_to(videos_url)
      end
    end
  end

  describe "#upvote" do
    before(:each) do
      controller.stub(:current_user => current_user)
    end

    it "upvotes the video" do
      current_user.should_receive(:up_vote!).with(video)
      put :upvote, :id => 42
    end
  end

  describe "#downvote" do
    before(:each) do
      controller.stub(:current_user => current_user)
    end

    it "downvotes the video" do
      current_user.should_receive(:down_vote!).with(video)
      put :downvote, :id => 42
    end
  end
end


