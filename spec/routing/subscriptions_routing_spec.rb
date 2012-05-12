require 'spec_helper'

describe "subscriptions routing" do
  it "routes the landing page" do
    { :get => "/landing" }.
      should route_to(
        :controller => "subscriptions",
        :action => "new"
      )
  end

  it "routes to the create method" do
    { :post => "/subscriptions" }.
      should route_to(
        :controller => "subscriptions",
        :action => "create"
      )
  end

  it "routes to the thank you page" do
    { :get => "/subscriptions/thanks" }.
      should route_to(
        :controller => "subscriptions",
        :action => "thanks"
      )
  end
end

