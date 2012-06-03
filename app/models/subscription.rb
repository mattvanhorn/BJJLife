# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer         not null, primary key
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer
#
# Indexes
#
#  index_subscriptions_on_email    (email) UNIQUE
#  index_subscriptions_on_user_id  (user_id)
#

require 'email_validator'
class Subscription < ActiveRecord::Base
  attr_accessible :email

  belongs_to :user

  validates :email, :presence => true,
                    :length => (3..254),
                    :uniqueness => true,
                    :email => true

end
