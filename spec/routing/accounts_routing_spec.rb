require 'spec_helper'

describe "accounts routing" do
  it "routes the registration page" do
    { :get => "/sign_up" }.
      should route_to(
        :controller => "accounts",
        :action => "new"
      )
  end

  it "routes the session creation action" do
    { :post => "/auth/identity/callback" }.
      should route_to(
        :controller => "sessions",
        :action => "create",
        :provider => "identity"
      )
  end

  it "routes the account page" do
    { :get => "/account" }.
      should route_to(
        :controller => "accounts",
        :action => "show"
      )
  end
end
