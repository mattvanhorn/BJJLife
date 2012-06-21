require 'spec_helper'

describe Admin::ProductsController do
  include NullDB::RSpec::NullifiedDatabase
  include AuthHelper

  let(:product){ mock_model(Product, :save => true) }

  before(:each) do
    controller.stub(:product).and_return(product)
    admin_login
  end

  it "should not reek" do
    get_source_file(__FILE__).should_not reek
  end

  describe "new" do
    it "exposes a product" do
      controller.should_receive(:product).and_return(product)
      get :new
    end
  end

  describe "create" do
    it "makes a product" do
      controller.should_receive(:product).at_least(:once).and_return(product)
      post :create
    end

    it "saves the product" do
      product.should_receive(:save).and_return(true)
      post :create
    end

    it "redirects to the admin product list" do
      post :create
      response.should redirect_to(admin_products_url)
    end
  end

  describe "edit" do
    it "exposes a product" do
      controller.should_receive(:product).and_return(product)
      get :edit, :id => '42'
    end
  end

  describe "update" do
    it "updates a product" do
      controller.should_receive(:product).at_least(:once).and_return(product)
      put :update, :id => '42'
    end

    it "saves the product" do
      product.should_receive(:save).and_return(true)
      put :update, :id => '42'
    end

    it "redirects to the admin product list" do
      put :update, :id => '42'
      response.should redirect_to(admin_products_url)
    end
  end
end
