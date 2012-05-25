require 'spec_helper'

module EmailValidatorSpec
  class Validatable
    include ActiveModel::Validations
    validates :email, :email => true
    def self.i18n_scope
      :activerecord
    end
  end
end

describe "A record validated with EmailValidator" do
  subject { EmailValidatorSpec::Validatable.new }

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

  valid_emails.each do |email|
    it "accepts #{email} as a valid email address" do
      subject.stub(:email => email)
      subject.should be_valid
    end
  end

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

  invalid_emails.each do |email|
    it "rejects #{email} as an invalid email address" do
      subject.stub(:email => email)
      subject.should have(1).error_on(:email)
    end
  end
end