require 'spec_helper'

describe "blog routing" do
  it "routes a blog posts page" do
    { :get => "/blogs/42" }.
      should route_to(
        :controller => "blogs",
        :action => "show",
        :id => '42'
      )
  end
end