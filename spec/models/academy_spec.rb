# == Schema Information
#
# Table name: academies
#
#  id           :integer         not null, primary key
#  name         :string(255)     not null
#  instructor   :string(255)
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


  it "can get and set a name" do
    subject.name = "Vitor Shaolin's Brazilian Jiu Jitsu"
    subject.name.should == "Vitor Shaolin's Brazilian Jiu Jitsu"
  end

  it "can get and set an instructor" do
    subject.instructor = "Vitor Shaolin"
    subject.instructor.should == "Vitor Shaolin"
  end

  describe "contact info" do
    let(:contact_info){ OpenStruct.new(:email => 'tkd@4blackbelt.com', :phone_number => '212-957-4045', :website => 'http://bjjnewyorkcity.com/') }
    stub_class("ContactInfo")
    it "should set contact info" do
      subject.contact_info = contact_info

      subject.email.should == 'tkd@4blackbelt.com'
      subject.phone_number.should == '212-957-4045'
      subject.website.should == 'http://bjjnewyorkcity.com/'
    end

    it "should get contact info" do
      subject.email = 'tkd@4blackbelt.com'
      subject.phone_number = '212-957-4045'
      subject.website = 'http://bjjnewyorkcity.com/'
      ContactInfo.should_receive(:new).with('tkd@4blackbelt.com', '212-957-4045', 'http://bjjnewyorkcity.com/').and_return(contact_info)
      subject.contact_info.should equal(contact_info)
    end
  end

  it { should validate_with AcademyValidator }

  # it { should validate_presence_of(:name) }

  # it{ should ensure_length_of(:email).is_at_least(3).is_at_most(254) }

  # it "validates the format of email" do
  #   subject.class.validators_on(:email).select{|v|v.is_a? (EmailValidator)}.should_not be_empty
  # end

  # it { should validate_with ContactMethodValidator }

  it { should_not be_published }

  it { should be_pending }

  describe "being published" do
    before(:each) do
      subject.name = "Vitor Shaolin's Brazilian Jiu Jitsu"
      subject.email = 'tkd@4blackbelt.com'
      subject.location = stub_model(AcademyLocation, :valid? => true)
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

  describe ".near" do
    it "should find no academies without a geocoded location" do
      Academy.near(nil).should == []
    end
    it "finds academies near a geocoded location" do
      expected = Academy.new
      result = [stub_model(AcademyLocation, :locatable => expected)]
      AcademyLocation.should_receive(:near).with([40,-70],100,{}).and_return(result)
      Academy.near([40,-70]).should == [expected]
    end
  end
end

