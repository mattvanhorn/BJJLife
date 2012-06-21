require 'spec_helper'

describe "products routing" do
  it "routes the products page" do
    { :get => "/products" }.
      should route_to(
        :controller => "products",
        :action => "index"
      )
  end

  it "routes the product details page" do
    { :get => "/products/42" }.
      should route_to(
        :controller => "products",
        :action => "show",
        :id => '42'
      )
  end
end


describe "products admin routing" do
  it "routes the list of products" do
    { :get => "/admin/products" }.
      should route_to(
        :controller => "admin/products",
        :action => "index"
      )
  end

  it "routes the new product page" do
    { :get => "/admin/products/new" }.
      should route_to(
        :controller => "admin/products",
        :action => "new"
      )
  end

  it "routes to the create method" do
    { :post => "/admin/products" }.
      should route_to(
        :controller => "admin/products",
        :action => "create"
      )
  end

  it "routes the edit product page" do
    { :get => "/admin/products/42/edit" }.
      should route_to(
        :controller => "admin/products",
        :action => "edit",
        :id => '42'
      )
  end

  it "routes to the update method" do
    { :put => "/admin/products/42" }.
      should route_to(
        :controller => "admin/products",
        :action => "update",
        :id => '42'
      )
  end
end