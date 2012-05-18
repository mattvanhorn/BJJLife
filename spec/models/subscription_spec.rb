require 'spec_helper'

describe Subscription do
  include NullDB::RSpec::NullifiedDatabase

  let(:subscription){ Subscription.new }

  subject{ subscription }

  it "should validate the uniqueness of email" do
    subject.class.validators_on(:email).select{|v|v.is_a? (ActiveRecord::Validations::UniquenessValidator)}.should_not be_empty
    subject.should have_db_index(:email).unique(true)
  end

  it{ should validate_presence_of(:email) }

  it{ should ensure_length_of(:email).is_at_least(3).is_at_most(254) }

  it "validates the format of email" do
    valid_emails = [
      %("Abc\@def"@example.com),
      %("Fred Bloggs"@example.com),
      %("Joe\\Blow"@example.com),
      %("Abc@def"@example.com),
      %(customer/department=shipping@example.com),
      %($A12345@example.com),
      %(!def!xyz%abc@example.com),
      %(_somename@example.com)
    ]
    invalid_emails = [
      %(NotAnEmail),
      %(@NotAnEmail),
      %(""test\blah""@example.com),
      %(Ima Fool@example.com),
      %(.@example.com),
      %(pootietang.@example.com),
      %(wo..oly@example.com),
      %(.wooly@example.com),
      %(""test""blah""@example.com),
      %(\"test\rblah\"@example.com)
    ]
    valid_emails.each do |email|
      Subscription.new(:email => email).should be_valid
    end
    invalid_emails.each do |email|
      Subscription.new(:email => email).should_not be_valid
    end

  end
end