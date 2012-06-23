require 'spec_helper'

describe ProductsController do
  let(:products){ [] }
  let(:product){ Object.new }

  before(:each) do
    Product.stub(:categorized_for).and_return(products)
    products.stub(:find).and_return(product)
  end

  describe "#index" do
    it "exposes the products" do
      Product.should_receive(:categorized_for).and_return(products)
      controller.products.should equal(products)
    end

    it "exhibits all the products and categories" do
      controller.should_receive(:exhibit_exposed).with(:products, :categories_in_use)
      get :index
    end
  end

  describe "#show" do
    it "exposes a product" do
      products.should_receive(:find).with('42').and_return(product)
      controller.stub(:params => {:id => '42'})
      controller.product.should equal(product)
    end

    it "exhibits a product" do
      controller.should_receive(:exhibit_exposed).with(:product)
      get :show, :id => '42'
    end
  end


end
