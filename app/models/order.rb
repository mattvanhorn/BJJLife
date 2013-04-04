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
# Indexes
#
#  index_orders_on_user_id  (user_id)
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
    card = create_charge
    record_cc_info(card) if card
    cleanup
    return false if errors.any?
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
      add_stripe_error(e, 'STRIPE CREATE CHARGE FAILED WITH CARD ERROR')

    rescue Stripe::InvalidRequestError, Stripe::APIError => e
      add_stripe_error(e, 'STRIPE CREATE CHARGE FAILED')
    end
    cleanup and return false
  end

  def chargeable?
    !!(stripe_card_token && amount > 50 && user.try(:valid?))
  end

  def send_confirmation
    OrderMailer.confirmation(self).deliver
  end

  def merge_identity_errors(i_errors)
    i_errors.each do |key, msg|
      unless common_keys(i_errors).include?(key)
        msg = i_errors.full_message(key, msg)
        key = :base
      end
      errors.add(key, msg)
    end
  end

  private

  def common_keys(error_hash)
    error_hash.keys.map(&:to_sym) & attributes.keys.map(&:to_sym)
  end

  def add_stripe_error(error, log_prefix)
    msg = error.message
    Rails.logger.error("#{log_prefix}: #{msg}")
    errors.add(stripe_error_key(error), msg)
  end

  def stripe_error_key(error)
    return :base unless error.respond_to? :code
    case error.code
      when "invalid_number", "incorrect_number"
        :card_number

      when "invalid_expiry_month"
        :cc_exp_month

      when "invalid_expiry_year"
        :cc_exp_year

      when "invalid_cvc", "incorrect_cvc"
        :card_code

      else
        :base
    end
  end

  def record_cc_info(card)
    CC_RESULT_FIELDS.each do |field|
      send :"cc_#{field}=", card.send(field)
    end
  end

  def cleanup
    self.stripe_card_token = nil
  end

end
