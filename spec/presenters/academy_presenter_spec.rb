require 'ostruct'
require 'support/constant_stubbing'
require 'display_case'
require_relative "../../app/models/address"
require_relative "../../app/presenters/academy_presenter"

describe AcademyPresenter do
  stub_class('Academy')
  stub_class('AcademyGroup')
  stub_class('Geocoder')
  let(:location){ 'foo' }
  let(:context){ 'bar' }
  let(:academy){ Object.new}
  let(:academy_group){ Object.new }
  subject(:presenter){ AcademyPresenter.new(context, location) }

  before(:each) do
    Academy.stub_chain('published.ordered_by_state.group_by').and_return({'NY' => [academy]})
    Academy.stub_chain('published.ordered_by_country.group_by').and_return({'Brazil' => [academy]})
    Academy.stub_chain('published.near').and_return([academy])
    AcademyGroup.stub(:new => academy_group)
    Geocoder.stub(:search => [stub(:coordinates => [42.0,69.0])])
    I18n.stub(:t => 'Nearest Academies')
  end

  it "returns academies groups for each state" do
    AcademyGroup.should_receive(:new).with('New York', 'NY', [academy]).and_return([academy_group])
    presenter.by_state
  end

  it "exhibits the academies groups" do
    presenter.should_receive(:exhibit).with([academy_group], context)
    presenter.by_state
  end

  it "returns academies groups for each country" do
    AcademyGroup.should_receive(:new).with('Brazil', 'Brazil', [academy]).and_return([academy_group])
    presenter.by_country
  end

  it "exhibits the academies groups" do
    presenter.should_receive(:exhibit).with([academy_group], context)
    presenter.by_country
  end

  it "has no nearest academies without a location" do
    Geocoder.stub(:search => [])
    AcademyPresenter.new(context, nil).nearest.should be_empty
  end

  it "returns nearest academies for a location string" do
    I18n.should_receive(:t).and_return('Nearest Academies')
    AcademyGroup.should_receive(:new).with('Nearest Academies: 10014', 'nearest', [academy]).and_return([academy_group])
    AcademyPresenter.new(context, '10014').nearest
  end

  it "exhibits nearest academies" do
    presenter.should_receive(:exhibit).with([academy_group], context)
    presenter.nearest
  end

end
