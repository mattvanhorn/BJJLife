require 'spec_helper'

describe Admin::CategoriesController do
  include NullDB::RSpec::NullifiedDatabase
  include AuthHelper

  let(:resource){ mock_model(Category, :save => true) }

  before(:each) do
    subject.stub(:category => resource)
    admin_login
  end


  describe "#index" do
    it "exhibits the categories" do
      controller.should_receive(:exhibit_exposed).with(:categories)
      get :index
    end
  end

  describe "#new" do
    it "exhibits the category" do
      controller.should_receive(:exhibit_exposed).with(:category)
      get :new
    end
  end

  describe "create" do
    let(:category){ resource }

    it "creates a category" do
      controller.should_receive(:category).and_return(category)
      post :create
    end

    it "saves the category" do
      category.should_receive(:save).and_return(true)
      post :create
    end

    it "redirects to the admin category list" do
      post :create
      response.should redirect_to(admin_categories_url)
    end

    it "exhibits the categories" do
      controller.should_receive(:exhibit_exposed).with(:categories, :category)
      post :create
    end
  end

  describe "destroy" do
    let(:category){ resource }

    it "destroys a category" do
      category.should_receive(:destroy).and_return(category)
      delete :destroy, :id => 42
    end

    it "exhibits the categories" do
      controller.should_receive(:exhibit_exposed).with(:categories)
      delete :destroy, :id => 42
    end

    it "redirects to the admin category list" do
      category.stub(:destroy => category)
      delete :destroy, :id => 42
      response.should redirect_to(admin_categories_url)
    end
  end
end
