require 'spec_helper'

describe AcademiesController do


  describe "#index" do
    it "renders the correct template" do
      get :index
      response.should render_template(:index)
    end
  end


  describe "#new" do
    it "renders the correct template" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "#create" do
    let(:academy){ mock_model(Academy, :save => true) }

    describe "with valid params" do
      before(:each) do
        subject.stub(:academy => academy)
      end

      let(:valid_params){ { 'name' => "Vitor Shaolin's Brazilian Jiu Jitsu",
                            'email' => 'tkd@4blackbelt.com',
                            'postal_code' => '10036'} }

      it "saves a academy" do
        academy.should_receive(:save).and_return(true)
        post :create, :academy => valid_params
      end

      it "redirects to the list page" do
        post :create, :academy => valid_params
        response.should redirect_to(academies_url)
      end
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
