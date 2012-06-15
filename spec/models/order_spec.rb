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

require 'spec_helper'

describe Order do
  include NullDB::RSpec::NullifiedDatabase

  let(:item){ mock_model(OrderItem, :adjusted_subtotal => 1000).as_null_object }
  let(:product){ mock_model(Product, :price => 1000) }
  let(:user){ mock_model(User, :id => '1234') }
  let(:the_order){ Order.new{|o|o.user = user} }

  subject { the_order }

  context "when new" do
    it { should be_pending }
    its(:item){ should be_nil }
    its(:currency){ should == 'usd' }
    it { should_not be_chargeable }
  end

  context "without a user" do
    before do
      the_order.add_item(product)
      the_order.stripe_card_token = 'something'
      the_order.user = nil
    end
    it { should_not be_chargeable }
    it { should_not be_valid }
  end

  context "with an invalid user" do
    before do
      the_order.add_item(product)
      the_order.stripe_card_token = 'something'
      the_order.user = mock_model(User, :valid? => false)
    end
    it { should_not be_chargeable }
    it { should_not be_valid }
  end

  describe "adding a product" do
    before do
      the_order.stub(:build_item => item)
    end

    it "builds the item for itself" do
      the_order.should_receive(:build_item).and_return(item)
      the_order.add_item(product)
    end
    
    it "updates its amount" do
      the_order.should_receive(:amount=).with(1000)
      the_order.add_item(product)
    end
    
    it "sets the quantity" do
      item.should_receive(:quantity=).with(1)
      the_order.add_item(product)
    end

    it "sets the product" do
      item.should_receive(:product=).with(product)
      the_order.add_item(product)
    end

    it "sets the quantity" do
      item.should_receive(:unit_price=).with(1000)
      the_order.add_item(product)
    end

  end

  describe "#create_charge" do
    before(:each) do
      the_order.stripe_card_token = 'something'
      the_order.user = user
      the_order.add_item(product)
    end

    # NB: CANNOT USE ERRORS_ON, SINCE IT CALLS VALID? UNDER THE HOOD
    # AND THAT CLEARS OUT THE ERRORS THAT WE ADD WHEN CHARGING
    # the_order.should have(1).error_on(:card_number) <- WON'T PASS

    it "handles an invalid card number" do
      Stripe::Charge.should_receive(:create).and_raise Stripe::CardError.new('The card number is invalid', 'number', 'invalid_number')
      the_order.checkout
      the_order.errors[:card_number].should include('The card number is invalid')
    end

    it "handles an incorrect card number" do
      Stripe::Charge.should_receive(:create).and_raise Stripe::CardError.new('The card number is incorrect', 'number', 'incorrect_number')
      the_order.checkout
      the_order.errors[:card_number].should include('The card number is incorrect')
    end

    it "handles an invalid month" do
      Stripe::Charge.should_receive(:create).and_raise Stripe::CardError.new("The card's expiration month is invalid", 'exp_month', 'invalid_expiry_month')
      the_order.checkout
      the_order.errors[:cc_exp_month].should include("The card's expiration month is invalid")
    end

    it "handles an invalid year" do
      Stripe::Charge.should_receive(:create).and_raise Stripe::CardError.new("The card's expiration year is invalid", 'exp_year', 'invalid_expiry_year')
      the_order.checkout
      the_order.errors[:cc_exp_year].should include("The card's expiration year is invalid")
    end

    it "handles an invalid CVC" do
      Stripe::Charge.should_receive(:create).and_raise Stripe::CardError.new("The card's security code is invalid", 'code', 'invalid_cvc')
      the_order.checkout
      the_order.errors[:card_code].should include("The card's security code is invalid")
    end

    it "handles an incorrect CVC" do
      Stripe::Charge.should_receive(:create).and_raise Stripe::CardError.new("The card's security code is incorrect", 'code', 'incorrect_cvc')
      the_order.checkout
      the_order.errors[:card_code].should include("The card's security code is incorrect")
    end

    it "handles an expired card" do
      Stripe::Charge.should_receive(:create).and_raise Stripe::CardError.new("The card has expired", 'number', 'expired_card')
      the_order.checkout
      the_order.errors[:base].should include("The card has expired")
    end

    it "handles a declined card" do
      Stripe::Charge.should_receive(:create).and_raise Stripe::CardError.new("The card was declined.", 'number', 'card_declined')
      the_order.checkout
      the_order.errors[:base].should include("The card was declined.")
    end

    it "handles a duplicate transaction" do
      Stripe::Charge.should_receive(:create).and_raise Stripe::CardError.new("A transaction with identical amount and credit card information was submitted very recently.", nil, 'duplicate_transaction')
      the_order.checkout
      the_order.errors[:base].should include("A transaction with identical amount and credit card information was submitted very recently.")
    end

    it "handles an API error" do
      Stripe::Charge.should_receive(:create).and_raise Stripe::CardError.new("An error occurred while processing the card.", nil, 'processing_error')
      the_order.checkout
      the_order.errors[:base].should include("An error occurred while processing the card.")
    end
  end

  describe "checking out" do
    before(:each) do
      the_order.stripe_card_token = 'something'
      the_order.email = 'alice@example.com'
      the_order.add_item(product)
    end

    # Recorded response created using token: tok_yrkNU9PEHJWNJZ
    describe "when doing a sucessful checkout", :vcr => { :cassette_name => "stripe_api/create_charge/success" } do
      before { OrderMailer.stub_chain(:confirmation, :deliver) }
      it "processes the payment" do
        the_order.should_receive(:process_payment)
      end
      it "sends a confirmation" do
        the_order.should_receive(:send_confirmation)
      end
      after { the_order.checkout }
    end

    # Recorded response created using token: tok_yrkNU9PEHJWNJZ
    describe "after a successful checkout", :vcr => { :cassette_name => "stripe_api/create_charge/success" } do
      before do
        OrderMailer.stub_chain(:confirmation, :deliver)
        the_order.checkout
      end
      it { should be_persisted }
      it { should be_paid }
      its(:cc_type)       { should == 'Visa' }
      its(:cc_exp_month)  { should == 6 }
      its(:cc_exp_year)   { should == 2013 }
      its(:cc_last4)      { should == '4242' }
      its(:cc_fingerprint){ should == 'gDoFIK6m5B6tCyhg' }
      its(:cc_country)    { should == 'US' }
    end

    #  Recorded response created using token: tok_c26f9dU6RVl8f1
    describe "when a card is declined", :vcr => { :cassette_name => "stripe_api/create_charge/card_declined" } do
      it "sends no confirmation" do
        the_order.should_not_receive(:send_confirmation)
      end
      after { the_order.checkout }
    end

    #  Recorded response created using token: tok_c26f9dU6RVl8f1
    describe "after card is declined", :vcr => { :cassette_name => "stripe_api/create_charge/card_declined" } do
      before{ the_order.checkout }
      it { should_not be_persisted }
      it { should_not be_paid }
      it { should be_pending }
      its(:stripe_card_token) { should be_nil }
      it "has errors" do
        the_order.errors[:base].should include("Your card was declined.")
      end
    end

    # Recorded response created using token: tok_yrkNU9PEHJWNJZ again
    describe "after unsuccessfully trying to reuse a token", :vcr => { :cassette_name => "stripe_api/create_charge/reused_token" } do
      before{ the_order.checkout }
      it { should_not be_persisted }
      it { should_not be_paid }
      it { should be_pending }
      its(:stripe_card_token) { should be_nil }
      it "has errors" do
        the_order.errors[:base].should include("You cannot use a stripe token more than once: tok_yrkNU9PEHJWNJZ")
      end
    end

    # Recorded response created using token: bad_token
    describe "unsuccessfully trying to use an invalid token", :vcr => { :cassette_name => "stripe_api/create_charge/invalid_token" } do
      before{ the_order.checkout }
      it { should_not be_persisted }
      it { should_not be_paid }
      it { should be_pending }
      its(:stripe_card_token) { should be_nil }
      it "has errors" do
        the_order.errors[:base].should include("Invalid token id: bad_token")
      end
    end

  end
end

