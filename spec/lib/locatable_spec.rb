require 'spec_helper'

class MyLocatable
  include ActiveModel::Validations
  include ActiveRecord::Validations
  # It's too much work to test the scopes here.
  def self.scope(*args);end
  def self.joins(*args);self;end
  def self.where(*args);self;end
  def self.includes(*args);self;end
  def self.order(*args);self;end
  include Locatable
  def new_record?;true;end
end

describe Locatable do
  let(:location){ Object.new }
  subject(:locatable) { MyLocatable.new }

  before(:each) do
    location.stub(:marked_for_destruction? => false)
    locatable.stub(:location => location)
    locatable.stub_chain(:joins, :where, :includes, :order).and_return(:fake_scope)
  end

  [:address, :street, :unit, :city, :us_state, :region, :country, :postal_code].each do |attr|
    it "delegates #{attr} to it's location" do
      locatable.location.should_receive(attr).and_return('foo')
      locatable.send(attr)
    end
  end

  it "is not valid if the location is not valid" do
    location.stub(:valid? => false)
    locatable.should_not be_valid
  end

  it "is valid if the location is valid" do
    location.stub(:valid? => true)
    locatable.should be_valid
  end

end
