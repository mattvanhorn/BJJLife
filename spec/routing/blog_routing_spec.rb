require 'spec_helper'

describe "blog routing" do
  it "routes the main list page" do
    { :get => "/blog" }.
      should route_to(
        :controller => "blog",
        :action => "index"
      )
  end
end