require 'spec_helper'

module ContactMethodValidatorSpec
  class Validatable
    include ActiveModel::Validations
    validates_with ContactMethodValidator
    def self.i18n_scope
      :activerecord
    end
  end
end

describe "A record validated with ContactMethodValidator" do
  subject { ContactMethodValidatorSpec::Validatable.new }

  before(:each) do
    subject.stub(:website => nil, :phone_number => nil, :email => nil)
  end

  it "should not reek" do
    get_source_file(__FILE__).should_not reek
  end

  it "is not valid without some minimal location info" do
    subject.should have(1).error_on(:base)
    subject.errors[:base].first.should == "You must provide at least one contact method (phone, email, or website)"
  end

  it "is not valid with empty strings" do
    subject.stub(:website => ' ', :phone_number => '', :email => '')
    subject.should have(1).error_on(:base)
  end

  it "is valid with just a website" do
    subject.stub(:website => 'http://www.example.com')
    subject.should be_valid
  end

  it "is valid with just a phone number" do
    subject.stub(:phone_number => '123-456-7890')
    subject.should be_valid
  end

  it "is valid with just an email address" do
    subject.stub(:email => 'alice@example.com')
    subject.should be_valid
  end
end

