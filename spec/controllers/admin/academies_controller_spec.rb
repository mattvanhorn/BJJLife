require 'spec_helper'

describe Admin::AcademiesController do
  include NullDB::RSpec::NullifiedDatabase
  include AuthHelper

  let(:resource){ mock_model(Academy) }
  let(:collection){ [resource] }

  before(:each) do
    subject.stub(:academy => resource, :academies => collection )
  end


  describe "#index" do
    it "renders the index template" do
      admin_login
      get :index
      response.should render_template(:index)
    end
  end

  describe "#publish" do
    let(:academy){ mock_model(Academy, :publish! => true) }

    before(:each) do
      admin_login
      controller.stub(:academy => academy)
    end

    it "publishes the academy" do
      academy.should_receive(:publish!)
      put :publish, :id => '42'
    end

    it "redirects to the admin academy list" do
      put :publish, :id => '42'
      response.should redirect_to(admin_academies_url)
    end
  end

end
