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
#

require 'spec_helper'

describe User do
  include NullDB::RSpec::NullifiedDatabase

  subject { User.new }

  it { should have_one(:identity) }

  it "should accept nested attributes for identity" do
    subject.should respond_to(:identity_attributes=)
    subject.identity_attributes = {'email' => 'foo'}
    subject.identity.email.should == 'foo'
  end

  it "knows when it is recently signed up" do
    subject.sign_in_count = 1
    subject.should be_first_sign_in
  end

  it "increments the sign in counter" do
    subject.sign_in_count = 1
    subject.sign_in!
    subject.sign_in_count.should == 2
  end

  it "knows the email address for its subscription" do
    subject.subscription = mock_model(Subscription, :email => 'foo@bar.com').as_null_object
    subject.subscribed_email.should == 'foo@bar.com'
  end

  it "knows the email address for its identity" do
    subject.identity = mock_model(Identity, :email => 'foo@bar.com').as_null_object
    subject.identity_email.should == 'foo@bar.com'
  end

  it "can have a pre-existing subscription" do
    subscription = mock_model(Subscription, :created_at => 1.week.ago, :persisted? => true).as_null_object
    subject.subscription = subscription
    subject.had_existing_subscription?.should be_true
  end

  it "can have a new subscription" do
    subject.created_at = 2.seconds.ago
    subscription = mock_model(Subscription, :created_at => 1.second.ago, :persisted? => true).as_null_object
    subject.subscription = subscription
    subject.has_new_subscription?.should be_true
  end

  it "can opt out of a subscription" do
    subject.subscription = nil
    subject.should be_opted_out
  end
end
