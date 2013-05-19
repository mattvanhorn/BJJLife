require 'active_support/core_ext/object/blank'
require_relative '../../config/initializers/array_extensions'
require_relative '../../app/models/address'

describe Address do
  subject(:address) { Address.new('350 5th Avenue', '600th Floor', 'New York', 'NY', '10001') }

  # Nova União (Academia Upper)
  # Rua Marques de Abrante, 88
  # Flamengo - Rio de Janeiro, RJ
  # 22230-061
  # Brazil

  describe "#street_address" do
    before(:each) do
      address.instance_variable_set(:@street, '123 Sesame St.')
      address.instance_variable_set(:@unit, 'trash can')
    end

    it "formats full street addresses" do
      address.street_address.should == '123 Sesame St., trash can'
    end

    it "formats partial street addresses" do
      address.instance_variable_set(:@unit, nil)
      address.street_address.should == '123 Sesame St.'
    end
  end

  describe "#city_state_zip" do
    before(:each) do
      address.instance_variable_set(:@city, 'Gotham')
      address.instance_variable_set(:@us_state, 'NY')
      address.instance_variable_set(:@postal_code, '11666')
    end

    it "formats city, state and postalcode" do
      address.city_state_zip.should == 'Gotham, NY 11666'
    end

    it "formats city & state" do
      address.instance_variable_set(:@postal_code, nil)
      address.city_state_zip.should == 'Gotham, NY'
    end

    it "formats postal code alone" do
      address.instance_variable_set(:@city, nil)
      address.instance_variable_set(:@us_state, nil)
      address.city_state_zip.should == '11666'
    end
  end

  it "has a string representation" do
    address.to_s.should == "350 5th Avenue, 600th Floor, New York, NY 10001"
  end

  it "can be inspected" do
    address.inspect.should == '<Address: @street="350 5th Avenue", @unit="600th Floor", @city="New York", @us_state="NY", @postal_code="10001">'
  end
end


