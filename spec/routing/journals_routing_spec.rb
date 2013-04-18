require 'spec_helper'

describe "journals routing" do

  it "routes to the show method" do
    { :get => "/journal" }.
      should route_to(
        :controller => "journals",
        :action => "show"
      )
  end

  it "routes to the new method" do
    { :get => "/journal/new" }.
      should route_to(
        :controller => "journals",
        :action => "new"
      )
  end

  it "routes to the create method" do
    { :post => "/journal" }.
      should route_to(
        :controller => "journals",
        :action => "create"
      )
  end

end
describe "journal entries routing" do

  it "routes to the new method" do
    { :get => "/journal/entries/new" }.
      should route_to(
        :controller => "journal_entries",
        :action => "new"
      )
  end

  it "routes to the create method" do
    { :post => "/journal/entries" }.
      should route_to(
        :controller => "journal_entries",
        :action => "create"
      )
  end

  it "routes to the show method" do
    { :get => "/journal/entries/42" }.
      should route_to(
        :controller => "journal_entries",
        :action => "show",
        :id => "42"
      )
  end

end
