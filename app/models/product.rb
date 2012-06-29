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
#  market_id   :integer
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#  index_products_on_market_id    (market_id)
#

class Product < ActiveRecord::Base
  attr_accessible :name, :price, :photo, :photo_cache, :category_id

  belongs_to :category
  belongs_to :market

  mount_uploader :photo, ProductPhotoUploader

  validates :name,
            :price,  :presence => true

  validates :price, :numericality => {:only_integer =>  true}

  scope :categorized, includes(:category).where('category_id IS NOT NULL').order('categories.name, products.name')
  scope :in_market, lambda{ |market| market ? where(:market_id => market.id) : scoped }

  def Product.categorized_for(market)
    categorized.in_market(market)
  end
end

