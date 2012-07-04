require "exhibit_spec_helper"
require_relative "../../app/exhibits/market_exhibit"

describe "MarketExhibit" do
  Delegator.class_eval { include RSpec::Mocks::Methods }
  stub_class 'Market'

  before { Market.stub(:new => double(:class => Market)) }
  subject { MarketExhibit }
  it { should apply_to Market.new }
end

describe MarketExhibit do
  let(:context) { Object.new }
  let(:market)  { OpenStruct.new(:name => "Gotham City") }
  let(:exhibit) { MarketExhibit.new(market, context) }

  subject { exhibit }

  its(:to_s){should == 'Gotham City'}

end
