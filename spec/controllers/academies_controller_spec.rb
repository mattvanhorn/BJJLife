require 'spec_helper'

describe AcademiesController do

  it "should not reek" do
    File.open(__FILE__).should_not reek
  end

  describe "#index" do
    it "exposes all published academies by state" do
      academies = double('academies list').as_null_object
      Academy.stub(:published => academies)
      actual = controller.send(:academies_by_state)
      actual.should == academies
    end
  end

  describe "#new" do
    it "renders the correct template" do
      get :new
      response.should render_template(:new)
    end

    it "exposes a new academy" do
      academy = mock_model(Academy)
      Academy.stub(:new => academy)
      actual = controller.send(:academy)
      actual.should == academy
    end

  end

  describe "#create" do
    let(:academy){ mock_model(Academy) }
    describe "with valid params" do
      let(:valid_params){ { 'name' => "Vitor Shaolin's Brazilian Jiu Jitsu",
                            'email' => 'tkd@4blackbelt.com',
                            'postal_code' => '10036'} }

      it "creates a pending academy" do
        Academy.should_receive(:new).with(valid_params).and_return(academy)
        academy.should_receive(:save).and_return(true)
        post :create, :academy => valid_params
      end

      it "redirects to the list page" do
        Academy.stub(:new).and_return(academy)
        academy.stub(:save).and_return(true)
        post :create, :academy => valid_params
        response.should redirect_to(academies_url)
      end
    end
  end

end