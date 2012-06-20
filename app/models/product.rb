# == Schema Information
#
# Table name: products
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  price       :integer
#  photo       :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  description :text
#  category_id :integer
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#

class Product < ActiveRecord::Base
  attr_accessible :name, :price, :photo, :photo_cache, :category_id

  belongs_to :category

  mount_uploader :photo, ProductPhotoUploader

  scope :categorized, includes(:category).where('category_id IS NOT NULL').order('categories.name')

  def self.categories
    Category.joins(:products).uniq.order(:name)
  end
end

