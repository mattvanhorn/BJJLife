# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer         not null, primary key
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer
#
# Indexes
#
#  index_subscriptions_on_email    (email) UNIQUE
#  index_subscriptions_on_user_id  (user_id)
#

require 'spec_helper'

describe Subscription do
  include NullDB::RSpec::NullifiedDatabase

  let(:subscription){ Subscription.new }

  subject{ subscription }

  it "should not reek" do
    get_source_file(__FILE__).should_not reek
  end

  it "should validate the uniqueness of email" do
    subject.class.validators_on(:email).select{|v|v.is_a? (ActiveRecord::Validations::UniquenessValidator)}.should_not be_empty
    subject.should have_db_index(:email).unique(true)
  end

  it{ should validate_presence_of(:email) }

  it{ should ensure_length_of(:email).is_at_least(3).is_at_most(254) }

  it "validates the format of email" do
    subject.class.validators_on(:email).select{|v|v.is_a? (EmailValidator)}.should_not be_empty
  end
end
