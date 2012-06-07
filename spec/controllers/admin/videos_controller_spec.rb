require 'spec_helper'

describe Admin::VideosController do
  include NullDB::RSpec::NullifiedDatabase

  let(:resource){ mock_model(Video, :save => true) }

  before(:each) do
    subject.stub(:video => resource)
  end

  it "should not reek" do
    get_source_file(__FILE__).should_not reek
  end

  describe "create" do
    let(:video){ resource }

    it "creates a video" do
      controller.should_receive(:video).and_return(video)
      post :create
    end

    it "saves the video" do
      video.should_receive(:save).and_return(true)
      post :create
    end

    it "redirects to the admin video list" do
      post :create
      response.should redirect_to(admin_videos_url)
    end
  end

  describe "destroy" do
    let(:video){ resource }

    it "destroys a video" do
      video.should_receive(:destroy).and_return(video)
      delete :destroy, :id => 42
    end

    it "redirects to the admin video list" do
      video.stub(:destroy => video)
      delete :destroy, :id => 42
      response.should redirect_to(admin_videos_url)
    end
  end
end
