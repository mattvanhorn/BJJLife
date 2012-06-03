# == Schema Information
#
# Table name: identities
#
#  id              :integer         not null, primary key
#  user_id         :integer
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#
# Indexes
#
#  index_identities_on_user_id  (user_id)
#

require 'spec_helper'

describe Identity do
  include NullDB::RSpec::NullifiedDatabase

  it "is useable by the OmniAuthenticator" do
    Identity.should_receive(:find_by_id).with('42')
    Identity.find_by_uid('42')
  end

  describe "being created" do
    let(:user){ mock_model(User) }
    let(:subscription){ mock_model(Subscription) }

    it "creates a subscription if opt in is true" do
      Subscription.should_receive(:find_or_create_by_email).with('alice@example.com')
      Identity.create(:email => 'alice@example.com',
                      :password => 'password',
                      :password_confirmation => 'password',
                      :opt_in => true)
    end

    it "assigns the subscription to the user" do
      Subscription.should_receive(:find_or_create_by_email).and_yield(subscription)
      identity = Identity.new(:email => 'alice@example.com',
                              :password => 'password',
                              :password_confirmation => 'password',
                              :opt_in => true)
      identity.user = user
      subscription.should_receive(:user=).with(identity.user)
      identity.save
    end

    it "removes any existing subscription if opt in is false" do
      Subscription.should_receive(:destroy_all).with(:email => 'alice@example.com')
      Identity.create(:email => 'alice@example.com',
                      :password => 'password',
                      :password_confirmation => 'password',
                      :opt_in => false)
    end
  end
end
