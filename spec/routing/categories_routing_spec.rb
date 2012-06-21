require 'spec_helper'

describe "categories routing" do
  it "routes the admin categories page" do
    { :get => "/admin/categories" }.
      should route_to(
        :controller => "admin/categories",
        :action => "index"
      )
  end

  it "routes the admin new category page" do
    { :get => "/admin/categories/new" }.
      should route_to(
        :controller => "admin/categories",
        :action => "new"
      )
  end

  it "routes the admin create category action" do
    { :post => "/admin/categories" }.
      should route_to(
        :controller => "admin/categories",
        :action => "create"
      )
  end
end
