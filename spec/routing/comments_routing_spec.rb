require 'spec_helper'

describe "comments routing" do
  it "routes the new comment page for a post" do
    { :get => "posts/42/comments/new" }.
      should route_to(
        :controller => "comments",
        :action => "new",
        :post_id => '42'
      )
  end

  it "routes to the create method" do
    { :post => "/posts/42/comments" }.
      should route_to(
        :controller => "comments",
        :action => "create",
        :post_id => '42'
      )
  end

end