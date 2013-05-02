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

require 'moderatable'

class Academy < ActiveRecord::Base
  include Moderatable
  include Locatable

  attr_accessible :name, :instructor, :location_attributes, :email, :phone_number, :website

  has_one :location, :as => :locatable, :class_name => 'AcademyLocation'

  accepts_nested_attributes_for :location, :update_only => true

  validates_with ContactMethodValidator
  validates_presence_of :name
  validates :email, :length => (3..254), :email => true, :allow_blank => true

  def self.near(origin, radius = NEARBY_DISTANCE, options = {})
    return [] if origin.blank?
    AcademyLocation.near(origin, radius, options).map(&:locatable).compact
  end

  def contact_info
    @contact_info ||= ContactInfo.new(email, phone_number, website)
  end

  def contact_info=(contact_info)
    @contact_info = contact_info

    self[:email]        = contact_info.email
    self[:phone_number] = contact_info.phone_number
    self[:website]      = contact_info.website
  end
end
