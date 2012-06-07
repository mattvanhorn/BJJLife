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

require 'spec_helper'

describe Product do
  it "can read and write a name" do
    subject.name = 'Foo Bar'
    subject.name.should == 'Foo Bar'
  end
  it "can read and write a price" do
    subject.price = 1000
    subject.price.should == 1000
  end
end
