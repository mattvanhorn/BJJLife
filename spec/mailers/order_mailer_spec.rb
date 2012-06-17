require "spec_helper"
require "email_spec"

describe OrderMailer do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  describe "confirmation email" do
    let(:order_item){ mock_model(OrderItem, :product_name => 'foobar',
                                            :quantity => 1,
                                            :adjusted_subtotal => 1000,
                                            :redemption_codes => [mock_model(RedemptionCode, :to_s => 'abc123')]) }
    let(:order){ mock_model(Order,  :email => 'alice@example.com',
                                    :item => order_item) }
    let(:email){ OrderMailer.confirmation(order) }

    subject { email }

    it { should deliver_to("alice@example.com") }

    it { should have_subject(/^Your Order Confirmation/) }

    it "should contain the redemption code in the mail body" do
      email.should have_body_text(/abc123/)
    end

    it "should contain a link to the confirmation link" do
      email.should have_body_text(/orders\/#{order.id}/)
    end



  end
end
