require 'spec_helper'

describe AcademiesController do

  describe "#index" do
    it "renders the correct template" do
      get :index
      response.should render_template(:index)
    end
  end

  describe "search" do
    let(:params){ {:academy_search =>{:location => '10014'}} }
    it "exhibits academies and search results" do
      controller.should_receive(:exhibit_exposed).with(:search_results, :academies_by_state)
      get :search, params
    end
    it "finds academies" do
      Geocoder.should_receive(:search).with('10014').and_return([OpenStruct.new(:coordinates => [40,-69])])
      Academy.should_receive(:near).with([40,-69], NEARBY_DISTANCE).and_return([])
      get :search, params
    end
  end

end
