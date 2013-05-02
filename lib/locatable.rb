module Locatable
  def self.included(base)
    base.class_exec do
      scope :ordered_by_state,   joins(:location).where('locations.country IS NULL').includes(:location).order('locations.us_state, name')
      scope :ordered_by_country, joins(:location).where('locations.country IS NOT NULL').includes(:location).order('locations.country, name')

      validates_associated :location, :on => :create

      delegate :address, :street, :unit, :city, :us_state, :region, :country, :postal_code, :to => :location
    end
  end
end

