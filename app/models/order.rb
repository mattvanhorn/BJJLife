# == Schema Information
#
# Table name: orders
#
#  id               :integer         not null, primary key
#  user_id          :integer
#  state            :string(255)
#  bill_first_name  :string(32)
#  bill_last_name   :string(32)
#  bill_street      :string(255)
#  bill_unit        :string(255)
#  bill_city        :string(255)
#  bill_us_state    :string(2)
#  bill_postal_code :string(10)
#  email            :string(255)
#  cc_type          :string(255)
#  cc_exp_month     :integer
#  cc_exp_year      :integer
#  cc_last4         :string(4)
#  cc_fingerprint   :string(255)
#  cc_country       :string(255)
#  currency         :string(3)       default("usd"), not null
#  amount           :integer         not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

class Order < ActiveRecord::Base
  attr_reader :card_number, :card_code
  attr_accessor   :stripe_card_token, :total
  attr_accessible :stripe_card_token,
                  :email,
                  :bill_first_name,
                  :bill_last_name,
                  :bill_street,
                  :bill_unit,
                  :bill_city,
                  :bill_us_state,
                  :bill_postal_code

  CC_RESULT_FIELDS = [:type, :country, :exp_month, :exp_year, :fingerprint, :last4]

  belongs_to :user
  has_one :item, :class_name => 'OrderItem', :dependent => :destroy
  has_many :transactions, :class_name => 'OrderTransaction', :dependent => :destroy
  has_many :adjustments,  :class_name => 'OrderAdjustment', :dependent => :destroy

  validates_presence_of :user_id, :amount, :email
  validates_associated :user

  state_machine :initial => :pending do
    state :pending
    state :paid
    state :rejected
    state :refunded

    before_transition [:pending, :rejected] => :paid, :do => :process_payment
    after_transition  [:pending, :rejected] => :paid, :do => :send_confirmation

    event :checkout do
      transition :pending => :paid
    end

    event :retry do
      transition :rejected => :paid
    end

    event :refund do
      transition :paid => :refunded
    end
  end

  def add_item(product, quantity = 1)
    build_item.tap do |item|
      item.quantity = quantity
      item.product = product
      item.unit_price = product.price
      self.amount = item.adjusted_subtotal + (amount || 0)
    end
  end

  def process_payment
    record_cc_info(create_charge) && cleanup
  end

  def create_charge
    return unless chargeable?
    begin
      return Stripe::Charge.create(
        :amount => amount,
        :currency => currency,
        :card => stripe_card_token,
        :description => "#{email} -- #{Time.now.to_s(:db)}"
      ).card
    rescue Stripe::CardError => e
      Rails.logger.error("STRIPE CREATE CHARGE FAILED WITH CARD ERROR: #{e.message}")
      case e.code
        when "invalid_number", "incorrect_number"
          errors.add(:card_number, e.message)

        when "invalid_expiry_month"
          errors.add(:cc_exp_month, e.message)

        when "invalid_expiry_year"
          errors.add(:cc_exp_year, e.message)

        when "invalid_cvc", "incorrect_cvc"
          errors.add(:card_code, e.message)

        else
          errors.add(:base, e.message)
      end
    rescue Stripe::InvalidRequestError, Stripe::APIError => e
      Rails.logger.error("STRIPE CREATE CHARGE FAILED: #{e.message}")
      errors.add(:base, e.message)
    end
    cleanup and return false
  end

  def chargeable?
    !!(stripe_card_token && amount > 50 && user.try(:valid?))
  end

  def send_confirmation
    OrderMailer.confirmation(self).deliver
  end

  private

  def record_cc_info(card)
    return unless card
    CC_RESULT_FIELDS.each do |field|
      send :"cc_#{field}=", card.send(field)
    end

  end

  def cleanup
    self.stripe_card_token = nil
  end
end
