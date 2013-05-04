require 'spec_helper'

describe AcademyListingsController do

  describe "#new" do
    it "renders the correct template" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "#create" do
    let(:academy_listing){ mock_model(AcademyListing, :save => true) }

    describe "with valid params" do
      before(:each) do
        subject.stub(:academy_listing => academy_listing)
      end

      let(:valid_params){ { 'name' => "Vitor Shaolin's Brazilian Jiu Jitsu",
                            'email' => 'tkd@4blackbelt.com',
                            'postal_code' => '10036'} }

      it "saves a academy" do
        academy_listing.should_receive(:save).and_return(true)
        post :create, :academy => valid_params
      end

      it "redirects to the list page" do
        post :create, :academy_listing => valid_params
        response.should redirect_to(academies_url)
      end
    end
  end
end
