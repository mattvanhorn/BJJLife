require 'display_case'
require 'ostruct'
require_relative '../../config/initializers/array_extensions'
require_relative '../../app/exhibits/address_exhibit'

describe AddressExhibit do
  let(:context)  { Object.new }
  let(:address){ OpenStruct.new }
  let(:exhibit)  { AddressExhibit.new(address, context) }
  
  it "formats full street addresses" do
    address.street = '123 Sesame St.'
    address.unit = 'trash can'
    exhibit.street_address.should == '123 Sesame St., trash can'
  end
  
  it "formats partial street addresses" do
    address.street = '123 Sesame St.'
    address.unit = nil
    exhibit.street_address.should == '123 Sesame St.'
  end
  
  it "formats full street addresses" do
    address.city = 'Gotham'
    address.us_state = 'NY'
    address.postal_code = '11666'
    exhibit.city_state_zip.should == 'Gotham, NY 11666'
  end
  
  it "formats full street addresses" do
    address.city = 'Gotham'
    address.us_state = 'NY'
    address.postal_code = nil
    exhibit.city_state_zip.should == 'Gotham, NY'
  end
  
  it "formats full street addresses" do
    address.city = nil
    address.us_state = nil
    address.postal_code = '11666'
    exhibit.city_state_zip.should == '11666'
  end
end
