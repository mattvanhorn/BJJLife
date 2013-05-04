require 'spec_helper'

module AcademyValidatorSpec
  class Validatable
    include ActiveModel::Validations
    validates_with AcademyValidator
    def self.i18n_scope
      :activerecord
    end
  end
end

describe "A record validated with AcademyValidator" do
  let(:location){ stub(:valid? => true) }
  subject { AcademyValidatorSpec::Validatable.new }

  describe "with a name" do
    before(:each) do
      subject.stub(:name => 'Inigo Montoya')
      subject.stub(:website => nil, :phone_number => nil, :email => nil)
    end

    it "is not valid without some minimal contact info" do
      subject.should_not be_valid
      subject.should have(1).error_on(:base)
      subject.errors[:base].first.should == "You must provide at least one contact method (phone, email, or website)"
    end

    it "is not valid with empty strings" do
      subject.should_not be_valid
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

  describe "with contact info" do
    before(:each) do
      subject.stub(:website => 'www.example.com', :phone_number => '212-555-1212', :email => 'alice@example.com')
    end

    it "is valid with a name" do
      subject.stub(:name => 'Inigo Montoya')
      subject.should be_valid
    end

    it "is not valid without a name" do
      subject.stub(:name => nil)
      subject.should_not be_valid
      subject.should have(1).error_on(:name)
      subject.errors[:name].first.should == "can't be blank"
    end
  end
end
