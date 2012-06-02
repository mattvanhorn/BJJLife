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

require 'email_validator'
class Subscription < ActiveRecord::Base
  attr_accessible :email

  belongs_to :user

  validates :email, :presence => true,
                    :length => (3..254),
                    :uniqueness => true,
                    :email => true

end
