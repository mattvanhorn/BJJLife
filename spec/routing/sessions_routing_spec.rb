require 'spec_helper'

describe "sessions routing" do

  it "routes the sign-in page" do
    { :post => "/sign_in" }.
      should route_to(
        :controller => "sessions",
        :action => "new"
      )
  end

  it "routes the sign-out page" do
    { :post => "/sign_out" }.
      should route_to(
        :controller => "sessions",
        :action => "destroy"
      )
  end

end
