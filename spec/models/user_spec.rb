require 'spec_helper'

describe User do
  it { should have_one(:identity) }
  it "should accept nested attributes for identity" do
    subject.should respond_to(:identity_attributes=)
    subject.identity_attributes = {'email' => 'foo'}
    subject.identity.email.should == 'foo'
  end
end
