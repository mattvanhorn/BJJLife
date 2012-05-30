require 'spec_helper'

describe "admin routing" do
  it "routes the home page" do
    { :get => "/admin" }.
      should route_to(
        :controller => "admin/home",
        :action => "index"
      )
  end
end