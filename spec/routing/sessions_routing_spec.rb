require 'spec_helper'

describe "sessions routing" do

  it "routes the login page" do
    { :post => "/sign_in" }.
      should route_to(
        :controller => "sessions",
        :action => "new"
      )
  end

end
