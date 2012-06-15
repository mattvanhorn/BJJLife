require 'spec_helper'

describe ProductsController do
  let(:resource){ mock_model(Product, :save => true) }

  before(:each) do
    Product.stub(:new => resource)
  end

  describe "#show" do
    it "exhibits a product" do
      controller.should_receive(:exhibit_exposed).with(:product)
      get :show, :id => '42'
    end
  end


end
