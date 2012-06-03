require 'spec_helper'

describe "posts routing" do
  it "routes the new post page" do
    { :get => "/posts/new" }.
      should route_to(
        :controller => "posts",
        :action => "new"
      )
  end

  it "routes to the create method" do
    { :post => "/posts" }.
      should route_to(
        :controller => "posts",
        :action => "create"
      )
  end

  it "routes a post page" do
    { :get => "/posts/42" }.
      should route_to(
        :controller => "posts",
        :action => "show",
        :id => '42'
      )
  end
end