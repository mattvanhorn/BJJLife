require 'spec_helper'

describe "academies routing" do
  it "routes the academies page" do
    { :get => "/academies" }.
      should route_to(
        :controller => "academies",
        :action => "index"
      )
  end

  it "routes the new academy page" do
    { :get => "/academies/new" }.
      should route_to(
        :controller => "academies",
        :action => "new"
      )
  end
  
  it "routes the create academy action" do
    { :post => "/academies" }.
      should route_to(
        :controller => "academies",
        :action => "create"
      )
  end
end
