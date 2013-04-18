require 'spec_helper'
require 'ostruct'

describe JournalsController do
  let(:journals){ [] }
  let(:user){ Object.new }
  before(:each) do
    user.stub(:journals => journals)
    subject.stub(:authenticate_user! => true, :current_user => user)
  end

  describe "#show" do
    it "requires a logged in user" do
      subject.should_receive(:authenticate_user!).and_return(true)
      get :show
    end

    context "with a user who has a journal" do
      it "renders the correct template" do
        user.stub(:journals => [Object.new])
        get :show
        response.should render_template(:show)
      end
    end

    context "with a user who has no journal" do
      it "redirects to the new journal page" do
        user.stub(:journal => nil)
        get :show
        response.should redirect_to(new_journal_url)
      end
    end
  end

  describe "#new" do
    it "renders the correct template" do
      journals.stub(:new => OpenStruct.new)
      get :new
      response.should render_template(:new)
    end
  end

  describe "#create" do
    let(:post_params){ {'journal' => {'name' => 'A journal'}}}

    it "renders the correct template" do
      journals.stub(:new => OpenStruct.new)
      post :create, post_params
      response.should redirect_to(journal_url)
    end
  end
end
