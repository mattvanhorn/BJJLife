# RSpec matcher for validates_with.
# https://gist.github.com/2032846
# Usage:
#
#     describe User do
#       it { should validate_with CustomValidator }
#     end

RSpec::Matchers.define :validate_with do |validator|
  match do |subject|
    subject.class.validators.map(&:class).include? validator
  end

  description do
    "validate with #{validator}"
  end

  failure_message_for_should do |text|
    "expected to validate with #{validator}"
  end

  failure_message_for_should_not do |text|
    "do not expected to validate with #{validator}"
  end
end