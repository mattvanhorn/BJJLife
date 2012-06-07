# == Schema Information
#
# Table name: products
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  price      :integer
#  photo      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Product < ActiveRecord::Base
  mount_uploader :photo, ProductPhotoUploader

  def description
    Faker::Lorem.paragraphs(2).join("\n\n")
  end
end

