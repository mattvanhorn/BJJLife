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
require 'moderatable'

class Academy < ActiveRecord::Base
  include Moderatable

  attr_accessible :name, :instructor, :street, :unit, :city, :us_state, :postal_code, :email, :phone_number, :website

  validates_with LocationValidator
  validates_with ContactMethodValidator
  validates_presence_of :name
  validates :email, :length => (3..254), :email => true, :allow_blank => true
  validates :us_state, :length => {:is => 2}, :allow_blank => true

  scope :ordered_by_state, published.order('us_state, name')

  def self.by_state
    Academy.ordered_by_state.group_by(&:us_state).to_a.each do |state_group|
      state_group.define_singleton_method :to_partial_path, lambda{'state'}
    end
  end
end
