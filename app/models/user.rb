# == Schema Information
#
# Table name: users
#
#  id            :integer         not null, primary key
#  username      :string(32)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  sign_in_count :integer         default(0), not null
#

class User < ActiveRecord::Base
  attr_accessible :identity_attributes, :username

  has_one :identity
  has_one :subscription

  accepts_nested_attributes_for :identity, :update_only => true

  def sign_in!
    self.sign_in_count = sign_in_count + 1
    save!
  end

  def first_sign_in?
    sign_in_count == 1
  end

  def subscribed_email
    subscription.try(:email)
  end
end
