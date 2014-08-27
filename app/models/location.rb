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

class Location < ActiveRecord::Base
  attr_accessible :address, :ip_address, :street, :unit, :city, :us_state, :postal_code, :country, :lat, :lng

  composed_of :address, :class_name => "Address",
                        :mapping => [ %w(street street),
                                      %w(unit unit),
                                      %w(city city),
                                      %w(us_state us_state),
                                      %w(postal_code postal_code) ]

  belongs_to :locatable, :polymorphic => true, :dependent => :destroy

  geocoded_by :geocoding_string
  reverse_geocoded_by :lat, :lng

  after_validation :geocode, :if => :needs_geocoding?

  def self.attributes_from_gecoder_result(result)
      { :city         => result.try(:city),
        :us_state     => result.try(:state_code),
        :country      => result.try(:country_code),
        :postal_code  => result.try(:postal_code),
        :lat          => result.try(:latitude),
        :lng          => result.try(:longitude) }
  end

  def address_changed?
    street_changed? || city_changed? || us_state_changed? || postal_code_changed? || country_changed?
  end

  def geocoding_string
    ip_address.presence ||  [street, city, us_state, postal_code, country].compact.join(', ')
  end

  def needs_geocoding?
    address.present? && address_changed? && (persisted? || [lat,lng].compact.size < 2)
  end

  def region
    us_state || country
  end

end
