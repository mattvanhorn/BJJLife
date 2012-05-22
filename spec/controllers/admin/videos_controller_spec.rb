require 'spec_helper'

describe Admin::VideosController do
  include NullDB::RSpec::NullifiedDatabase

  it "exposes a video" do
    actual = controller.send(:video)
    actual.should be_a(Video)
    actual.should be_new_record
  end

  describe "create" do
    let(:video){ mock_model(Video, :save => true) }

    it "creates a video" do
      Video.should_receive(:new).with('name' => 'foo', 'url' => 'bar').and_return(video)
      post :create, :video => {'name' => 'foo', 'url' => 'bar'}
    end

    it "saves the video" do
      Video.stub(:new => video)
      video.should_receive(:save).and_return(true)
      post :create, :video => {'name' => 'foo', 'url' => 'bar'}
    end

    it "redirects to the admin video list" do
      post :create, :video => {'name' => 'foo', 'url' => 'bar'}
      response.should redirect_to(admin_videos_url)
    end
  end

  describe "destroy" do
    let(:video){ mock_model(Video, :attributes= => true) }

    it "destroys a video" do
      video.should_receive(:destroy).and_return(video)
      Video.stub(:find => video)
      delete :destroy, :id => 42
    end

    it "redirects to the admin video list" do
      video.stub(:destroy => video)
      Video.stub(:find => video)
      delete :destroy, :id => 42
      response.should redirect_to(admin_videos_url)
    end
  end
end
