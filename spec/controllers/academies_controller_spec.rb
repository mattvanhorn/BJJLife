require 'spec_helper'

describe AcademiesController do

  let(:presenter){ stub() }
  let(:location){ stub(:city => 'Gotham', :us_state => 'NY', :country => nil) }

  describe "#index" do

    describe "when there is a located user" do
      it "exposes a presenter with the right location" do
        controller.stub(:identifiable_user => stub(:location => location))
        AcademyPresenter.should_receive(:new).with(controller, 'Gotham, NY').and_return(presenter)
        get :index
        controller.academies
      end
    end

    describe "when there is not a located user" do
      it "exposes a presenter with no location" do
        controller.stub(:identifiable_user => stub(:location => nil))
        AcademyPresenter.should_receive(:new).with(controller, nil).and_return(presenter)
        get :index
        controller.academies
      end
    end

    it "renders the correct template" do
      get :index
      response.should render_template(:index)
    end
  end

  describe "#search" do
    let(:params){ {:academy_search =>{:location => '10014'}} }
    before(:each) do
      Geocoder.stub(:search => [stub(:coordinates => [40,-69])])
    end
    it "translates the search query string to coordinates" do
      Geocoder.should_receive(:search).with('10014').and_return([stub(:coordinates => [40,-69])])
      get :search, params
      controller.academies
    end
    it "should expose an academies presenter" do
      AcademyPresenter.should_receive(:new).with(controller, '10014').and_return(presenter)
      get :search, params
      controller.academies
    end
    it "renders the correct template" do
      get :search, params
      response.should render_template(:search)
    end
  end
end
