# == Schema Information
#
# Table name: markets
#
#  id        :integer          not null, primary key
#  name      :string(255)
#  parent_id :integer
#  lft       :integer          not null
#  rgt       :integer          not null
#  depth     :integer          default(0), not null
#
# Indexes
#
#  index_markets_on_parent_id  (parent_id)
#

class Market < ActiveRecord::Base
  attr_accessible :name, :parent_id, :location

  has_many :products
  has_one :location, :as => :locatable

  acts_as_nested_set

  def self.create_constants
    root.leaves.each do |market|
      const_name = market.name.gsub(/[^\w]+/,'_').upcase
      const_set(const_name, market)
    end
  end

  def self.near(origin, radius = NEARBY_DISTANCE, options = {})
    return [] if origin.blank?
    Location.where(:locatable_type => name).near(origin, radius, options).map(&:locatable)
  end
end
