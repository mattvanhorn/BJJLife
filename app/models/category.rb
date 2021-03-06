# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
# Indexes
#
#  index_categories_on_name  (name) UNIQUE
#

class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :products

  validates :name, :presence => true, :uniqueness => true

  scope :in_use, joins(:products).uniq.order(:name)

end
