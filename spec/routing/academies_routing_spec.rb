require 'spec_helper'

describe "academies routing" do
  it "routes the academies page" do
    { :get => "/academies" }.
      should route_to(
        :controller => "academies",
        :action => "index"
      )
  end
end
