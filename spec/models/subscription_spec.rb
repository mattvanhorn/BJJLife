require 'spec_helper'

describe Subscription do
  include NullDB::RSpec::NullifiedDatabase

  let(:subscription){ Subscription.new }

  subject{ subscription }

  it "should not reek" do
    File.open(__FILE__).should_not reek
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