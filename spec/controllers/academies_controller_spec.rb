require 'spec_helper'

describe AcademiesController do

  it "should not reek" do
    get_source_file(__FILE__).should_not reek
  end

  describe "exposures" do
    before(:each) do
      Academy.stub(:by_state => [{'NY' => mock_model(Academy)}], :new => mock_model(Academy))
    end
    it { should expose(:academies_by_state).as(Academy.by_state) }
    it { should expose(:academy).as(Academy.new) }
  end

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