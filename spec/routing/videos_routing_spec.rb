require 'spec_helper'

describe "videos routing" do
  it "routes the videos page" do
    { :get => "/videos" }.
      should route_to(
        :controller => "videos",
        :action => "index"
      )
  end
end

describe "videos admin routing" do
  it "routes the list of videos" do
    { :get => "/admin/videos" }.
      should route_to(
        :controller => "admin/videos",
        :action => "index"
      )
  end

  it "routes the new video page" do
    { :get => "/admin/videos/new" }.
      should route_to(
        :controller => "admin/videos",
        :action => "new"
      )
  end

  it "routes to the create method" do
    { :post => "/admin/videos" }.
      should route_to(
        :controller => "admin/videos",
        :action => "create"
      )
  end

  it "routes to the destroy method" do
    { :delete => "/admin/videos/123" }.
      should route_to(
        :controller => "admin/videos",
        :action => "destroy",
        :id => "123"
      )
  end
end