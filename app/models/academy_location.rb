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

class AcademyLocation < Location
  belongs_to :academy, :foreign_key => "locatable_id", :class_name => "Academy"
  validates_with LocationValidator
  validates :us_state, :length => {:is => 2}, :allow_blank => true

  def address
    Address.new(street, unit, city, us_state, postal_code).freeze
  end
end
