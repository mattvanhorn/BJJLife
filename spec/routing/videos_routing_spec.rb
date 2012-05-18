require 'spec_helper'

describe "videos routing" do
  it "routes the list of subscriptions" do
    { :get => "/videos" }.
      should route_to(
        :controller => "videos",
        :action => "index"
      )
  end
end