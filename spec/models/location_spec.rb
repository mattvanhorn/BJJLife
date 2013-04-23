# == Schema Information
#
# Table name: locations
#
#  id             :integer         not null, primary key
#  type           :string(255)     default("Location"), not null
#  locatable_id   :integer
#  locatable_type :string(255)
#  lat            :decimal(15, 10)
#  lng            :decimal(15, 10)
#  ip_address     :string(45)
#  street         :string(255)
#  unit           :string(255)
#  city           :string(255)
#  us_state       :string(2)
#  postal_code    :string(255)
#  country        :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#
# Indexes
#
#  index_locations_on_locatable_id_and_locatable_type  (locatable_id,locatable_type)
#  index_locations_on_type                             (type)
#

require 'spec_helper'
require 'ostruct'

describe Location do
  include NullDB::RSpec::NullifiedDatabase

  let(:address_attribs){ {:street      => '350 5th Avenue',
                          :unit        => '600th Floor',
                          :city        => 'New York',
                          :us_state    => 'NY',
                          :postal_code => '10001'} }


  it "can translate from a geocoder result" do
    gc_result = OpenStruct.new( :city         => 'foo',
                                :state_code   => 'bar',
                                :postal_code  => 'baz',
                                :latitude     => 'qux',
                                :longitude    => 'quux')
    Location.attributes_from_gecoder_result(gc_result).should == {:city        => 'foo',
                                                                  :us_state    => 'bar',
                                                                  :country     => nil,
                                                                  :postal_code => 'baz',
                                                                  :lat         => 'qux',
                                                                  :lng         => 'quux'}


  end

  it "has an address" do
    location = Location.new(address_attribs)
    address = location.address
    address.street.should == location.street
    address.unit.should == location.unit
    address.city.should == location.city
    address.us_state.should == location.us_state
    address.postal_code.should == location.postal_code
  end

  it "uses the US state as region" do
    location = Location.new(address_attribs)
    location.region.should == location.us_state
  end

  it "uses the country as region when there is no US state" do
    address_attribs.delete(:us_state)
    location = Location.new(address_attribs.merge(:country => 'Brazil'))
    location.region.should == 'Brazil'
  end

  describe "geocoding from an IP address" do
    it "generates a string for geolocation" do
      location = Location.new(:ip_address => '127.0.0.1')
      location.geocoding_string.should == '127.0.0.1'
    end
  end

  describe "geocoding from a street address" do
    it "generates a string for geolocation" do
      location = Location.new(address_attribs)
      location.geocoding_string.should == '350 5th Avenue, New York, NY, 10001'
    end

    it "generates a string for geolocation with a partial address" do
      location = Location.new(:city => 'New York', :us_state => 'NY')
      location.geocoding_string.should == 'New York, NY'
    end

    it "generates a string for geolocation with just a postal code" do
      location = Location.new(:postal_code => '10001')
      location.geocoding_string.should == '10001'
    end
  end

  describe "changing attributes", :vcr => { :cassette_name => "geocoder/geocoding_success" } do
    let(:location){ Location.create(address_attribs) }
    [:street, :city, :us_state, :postal_code, :country].each do |attr|
      it "is changed if the #{attr.to_s.humanize.downcase} changes" do
        location.send(:"#{attr}=", 'foo')
        location.should be_address_changed
      end
    end
  end
end

