require 'spec_helper'

describe VideosController do
  include NullDB::RSpec::NullifiedDatabase

  let(:current_user) { double(:id => '123', :model => true) }
  let(:video) { mock_model(Video, :publish! => true) }

  before(:each) do
    controller.stub(:current_user => current_user)
    Video.stub(:new => video)
  end

  it "should not reek" do
    File.open(__FILE__).should_not reek
  end

  describe "exposures" do
    let(:video){ mock_model(Video)}
    let(:videos){ double('arel')}
    before(:each) do
      Video.stub(:all => videos, :new => video)
    end

    it { should expose(:videos).as(Video.all) }
    it { should expose(:video).as(Video.new)  }
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
    let(:videos){ [mock_model(Video, :publish! => true)] }
    let(:video){ videos.first }

    it "requires sign in" do
      controller.stub(:user_signed_in? => false)
      post :create
      response.should redirect_to(sign_in_path)
    end

    describe "with valid params" do
      let(:valid_params){ {'foo' => 'bar'} }

      it "creates a pending video" do
        Video.should_receive(:new).with(valid_params).and_return(video)
        video.should_receive(:publish!).and_return(true)
        post :create, :video => valid_params
      end

      it "redirects to the list page" do
        Video.stub(:new).and_return(video)
        video.stub(:publish!).and_return(true)
        post :create, :video => valid_params
        response.should redirect_to(videos_url)
      end
    end
  end
end


