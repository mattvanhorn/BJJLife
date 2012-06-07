require 'spec_helper'

describe "products routing" do
  it "routes the product details page" do
    { :get => "/products/42" }.
      should route_to(
        :controller => "products",
        :action => "show",
        :id => '42'
      )
  end
end
