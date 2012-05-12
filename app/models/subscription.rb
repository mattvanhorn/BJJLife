require 'email_validator'
class Subscription < ActiveRecord::Base
  attr_accessible :email

  validates :email, :presence => true,
                    :length => (3..254),
                    :uniqueness => true,
                    :email => true

end
