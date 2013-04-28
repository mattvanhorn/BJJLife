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

require 'support/active_record'
require 'support/geocoder'
require 'support/custom_matchers'
require 'shoulda-matchers'

require_relative "../../lib/validators/location_validator"
require_relative "../../app/models/address"
require_relative "../../app/models/location"
require_relative "../../app/models/academy_location"

describe AcademyLocation do
  include NullDB::RSpec::NullifiedDatabase

  before(:each) do
    Geocoder.stub(:search => [])
  end

  it { should validate_with(LocationValidator) }

  it { should ensure_length_of(:us_state).is_equal_to(2) }

end
