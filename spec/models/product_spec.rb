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

require 'spec_helper'

describe Product do
  include NullDB::RSpec::NullifiedDatabase

  let(:product){ Product.new }

  subject { product }

  it "can read and write a name" do
    product.name = 'Foo Bar'
    product.name.should == 'Foo Bar'
  end

  it "can read and write a price" do
    product.price = 1000
    product.price.should == 1000
  end

  it "can save and display photos" do
    product.photo = File.open(File.join(Rails.root, 'spec', 'support','images','sloth.jpg'))
    product.id = 1234
    product.save
    product.photo_url.should == '/carrierwave/product/photo/1234/sloth.jpg'
  end

  it "has a category" do
    category = mock_model(Category, :name => 'foo')
    product.category = category
    product.category.should equal(category)
  end
end
