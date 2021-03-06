require 'spec_helper'

module LocationValidatorSpec
  class Validatable
    include ActiveModel::Validations
    validates_with LocationValidator
    def self.i18n_scope
      :activerecord
    end
  end
end

describe "A record validated with LocationValidator" do
  subject { LocationValidatorSpec::Validatable.new }


  before(:each) do
    subject.stub(:city => nil, :us_state => nil, :postal_code => nil)
  end

  it "is not valid without some minimal location info" do
    subject.should_not be_valid
    subject.should have(1).error_on(:base)
    subject.errors[:base].first.should == "You must provide both city and state, or a postal code"
  end

  it "is not valid with empty strings" do
    subject.stub(:city => '', :us_state => ' ', :postal_code => '')
    subject.should_not be_valid
    subject.should have(1).error_on(:base)
  end

  it "is valid with just a postal code" do
    subject.stub(:postal_code => '12345')
    subject.should be_valid
  end

  it "is valid with both a city & state" do
    subject.stub(:city => 'New York', :us_state => 'NY')
    subject.should be_valid
  end

  it "is not valid with just a city" do
    subject.stub(:city => 'New York')
    subject.should_not be_valid
    subject.should have(1).error_on(:base)
  end

  it "is not valid with just a state" do
    subject.stub(:us_state => 'NY')
    subject.should_not be_valid
    subject.should have(1).error_on(:base)
  end
end
