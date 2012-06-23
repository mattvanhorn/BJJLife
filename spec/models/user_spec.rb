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

require 'spec_helper'

describe User do
  include NullDB::RSpec::NullifiedDatabase

  let(:user){ User.new }
  subject { user }

  it "should not reek" do
    get_source_file(__FILE__).should_not reek
  end

  it { should have_one(:identity) }

  it "should accept nested attributes for identity" do
    user.should respond_to(:identity_attributes=)
    user.identity_attributes = {'email' => 'foo'}
    user.identity.email.should == 'foo'
  end

  it "validates the associated identity" do
    user.identity = mock_model(Identity, :valid? => false).as_null_object
    user.should_not be_valid
    user.should have(1).error_on(:identity)
  end

  it "knows when it is recently signed up" do
    user.sign_in_count = 1
    user.should be_first_sign_in
  end

  it "increments the sign in counter" do
    user.sign_in_count = 1
    user.sign_in!
    user.sign_in_count.should == 2
  end

  it "knows the email address for its subscription" do
    user.subscription = mock_model(Subscription, :email => 'foo@bar.com').as_null_object
    user.subscribed_email.should == 'foo@bar.com'
  end

  it "knows the email address for its identity" do
    user.identity = mock_model(Identity, :email => 'foo@bar.com').as_null_object
    user.identity_email.should == 'foo@bar.com'
  end

  it "can have a pre-existing subscription" do
    subscription = mock_model(Subscription, :created_at => 1.week.ago, :persisted? => true).as_null_object
    user.subscription = subscription
    user.had_existing_subscription?.should be_true
  end

  it "can have a new subscription" do
    user.created_at = 2.seconds.ago
    subscription = mock_model(Subscription, :created_at => 1.second.ago, :persisted? => true).as_null_object
    user.subscription = subscription
    user.has_new_subscription?.should be_true
  end

  it "can opt out of a subscription" do
    user.subscription = nil
    user.should be_opted_out
  end
end
