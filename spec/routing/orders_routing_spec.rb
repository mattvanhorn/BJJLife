require 'spec_helper'

describe "orders routing" do
  it "routes the new order page" do
    { :get => "products/42/orders/new" }.
      should route_to(
        :controller => "orders",
        :action => "new",
        :product_id => '42'
      )
  end
  it "routes the create order action" do
    { :post => "products/42/orders" }.
      should route_to(
        :controller => "orders",
        :action => "create",
        :product_id => '42'
      )
  end
  it "routes the confirmation (show order) page" do
    { :get => "orders/42" }.
      should route_to(
        :controller => "orders",
        :action => "show",
        :id => '42'
      )
  end
end
