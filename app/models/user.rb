# == Schema Information
#
# Table name: users
#
#  id            :integer         not null, primary key
#  username      :string(32)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  sign_in_count :integer         default(0), not null
#  up_votes      :integer         default(0), not null
#  down_votes    :integer         default(0), not null
#  location      :string(255)
#  teacher       :string(255)
#  rank          :string(255)
#  market_id     :integer
#
# Indexes
#
#  index_users_on_market_id  (market_id)
#

class User < ActiveRecord::Base
  make_voter

  attr_accessible :identity_attributes, :username, :location, :teacher, :rank

  belongs_to :market

  has_one :identity
  has_one :subscription

  has_many :posts
  has_many :comments
  has_many :orders

  accepts_nested_attributes_for :identity, :update_only => true
  validates_associated :identity, :on => :create

  def sign_in!
    self.sign_in_count = sign_in_count + 1
    save!
    self
  end

  def first_sign_in?
    sign_in_count == 1
  end

  def subscribed_email
    subscription.try(:email)
  end

  def identity_email
    identity.try(:email)
  end

  def has_new_subscription?
    !(opted_out? || had_existing_subscription?)
  end

  def had_existing_subscription?
    sub = self.subscription
    sub && sub.persisted? && (sub.created_at < (self.created_at || Time.now))
  end

  def opted_out?
    subscription.nil?
  end

  def new_order(*args)
    orders.build(*args)
  end
end
