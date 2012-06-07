# == Schema Information
#
# Table name: academies
#
#  id           :integer         not null, primary key
#  name         :string(255)     not null
#  instructor   :string(255)
#  street       :string(255)
#  unit         :string(255)
#  city         :string(255)
#  us_state     :string(2)
#  postal_code  :string(255)
#  website      :string(255)
#  email        :string(255)
#  phone_number :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  state        :string(255)     default("pending")
#

require 'spec_helper'

describe Academy do
  include NullDB::RSpec::NullifiedDatabase

  subject { Academy.new }

  it "should not reek" do
    get_source_file(__FILE__).should_not reek
  end

  it "can get and set a name" do
    subject.name = "Vitor Shaolin's Brazilian Jiu Jitsu"
    subject.name.should == "Vitor Shaolin's Brazilian Jiu Jitsu"
  end

  it "can get and set an instructor" do
    subject.instructor = "Vitor Shaolin"
    subject.instructor.should == "Vitor Shaolin"
  end

  it "can get and set a city" do
    subject.city = 'New York'
    subject.city.should == 'New York'
  end

  it "can get and set a state" do
    subject.us_state = 'NY'
    subject.us_state.should == 'NY'
  end

  it "can get and set a website" do
    subject.website = 'http://bjjnewyorkcity.com/'
    subject.website.should == 'http://bjjnewyorkcity.com/'
  end

  it "can get and set a phone number" do
    subject.phone_number = '212-957-4045'
    subject.phone_number.should == '212-957-4045'
  end

  it "can get and set an email address" do
    subject.email = 'tkd@4blackbelt.com'
    subject.email.should == 'tkd@4blackbelt.com'
  end

  it "can get and set an street address" do
    subject.street = '780 8th Ave'
    subject.street.should == '780 8th Ave'
  end

  it "can get and set an unit" do
    subject.unit = '3rd floor'
    subject.unit.should == '3rd floor'
  end

  it "can get and set a postal code" do
    subject.postal_code = '10036'
    subject.postal_code.should == '10036'
  end

  it { should validate_presence_of(:name) }

  it{ should ensure_length_of(:email).is_at_least(3).is_at_most(254) }

  it "validates the format of email" do
    subject.class.validators_on(:email).select{|v|v.is_a? (EmailValidator)}.should_not be_empty
  end

  it { should validate_with LocationValidator }

  it { should validate_with ContactMethodValidator }

  it { should ensure_length_of(:us_state).is_equal_to(2) }

  it { should_not be_published }

  it { should be_pending }

  describe "being published" do
    before(:each) do
      subject.name = "Vitor Shaolin's Brazilian Jiu Jitsu"
      subject.email = 'tkd@4blackbelt.com'
      subject.postal_code = '10036'
    end

    it "is still pending after being saved" do
      subject.save!
      subject.should be_pending
    end

    it "can be published" do
      subject.publish!
      subject.should be_published
    end
  end

  describe ".by_state" do

    it "provides a partial path for rendering state groups" do
      Academy.should_receive(:ordered_by_state).and_return([subject])
      Academy.by_state.first.to_partial_path.should == 'state'
    end
  end
end

