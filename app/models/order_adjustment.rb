# == Schema Information
#
# Table name: order_adjustments
#
#  id         :integer         not null, primary key
#  order_id   :integer
#  amount     :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class OrderAdjustment < ActiveRecord::Base
  belongs_to :order
end
