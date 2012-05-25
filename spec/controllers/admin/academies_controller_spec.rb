require 'spec_helper'

describe Admin::AcademiesController do
  include NullDB::RSpec::NullifiedDatabase
  include AuthHelper

  it "exposes pending academies" do
    Academy.should_receive(:pending)
    actual = controller.send(:academies)
  end

  it "exposes an academy" do
    actual = controller.send(:academy)
    actual.should be_a(Academy)
    actual.should be_new_record
  end

  describe "#index" do
    it "renders the index template" do
      admin_login
      get :index
      response.should render_template(:index)
    end
  end



end
