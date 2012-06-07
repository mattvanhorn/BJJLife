# == Schema Information
#
# Table name: redemption_codes
#
#  id            :integer         not null, primary key
#  order_item_id :integer         not null
#  token         :string(255)     not null
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'securerandom'
require 'active_model/naming'
require 'active_model/conversion'

class RedemptionCode < ActiveRecord::Base

  after_initialize :generate_token

  def to_s
    token
  end

  private

  def generate_token
    return token unless new_record?
    self.token ||= SecureRandom.random_number(36**8).to_s(36)
  end
end
