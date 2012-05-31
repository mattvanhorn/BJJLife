class User < ActiveRecord::Base
  attr_accessible :identity_attributes, :username

  has_one :identity

  accepts_nested_attributes_for :identity, :update_only => true
end