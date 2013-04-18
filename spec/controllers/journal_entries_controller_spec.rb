require 'spec_helper'

describe JournalEntriesController do
  include NullDB::RSpec::NullifiedDatabase

  let(:the_entry){ mock_model(JournalEntry) }
  let(:entries) { double('entries', :new => the_entry).as_null_object }
  let(:journal)    { mock_model(Journal, :entries => entries) }
  let(:current_user) { double(:id => '123', :model => true, :journal => journal) }

  before(:each) do
    controller.stub(:current_user => current_user, :locate_user => true)
    the_entry.stub(:journal => journal, :attributes= => true, :save => true)
  end


  describe "#new" do
    it "requires sign in" do
      controller.stub(:user_signed_in? => false)
      get :new
      response.should redirect_to(sign_in_path)
    end

    it "exhibits the journal and entry" do
      controller.should_receive(:exhibit_exposed).with(:journal, :journal_entry)
      get :new
    end
  end

  describe "#create" do
    it "requires sign in" do
      controller.stub(:user_signed_in? => false)
      post :create
      response.should redirect_to(sign_in_path)
    end

    it "saves the entry" do
      the_entry.should_receive(:save)
      post :create
    end

    it "redirects to the entry page" do
      post :create
      response.should redirect_to(journal_entry_path(the_entry))
    end

    it "exhibits the entry" do
      controller.should_receive(:exhibit_exposed).with(:journal_entry)
      post :create
    end
  end

  describe "show" do
    before(:each) do
      entries.stub(:find => the_entry)
    end
    it "requires sign in" do
      controller.stub(:user_signed_in? => false)
      post :create
      response.should redirect_to(sign_in_path)
    end

    it "finds the entry" do
      entries.should_receive(:find).with('42').and_return(the_entry)
      get :show, :id => '42'
    end

    it "exhibits the entry" do
      controller.should_receive(:exhibit_exposed).with(:journal_entry)
      get :show, :id => '42'
    end

    it "renders the show template" do
      get :show, :id => '42'
      response.should render_template(:show)
    end
  end
end

