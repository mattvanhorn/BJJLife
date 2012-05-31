require_relative "../../lib/omni_authenticator"
require 'ostruct'

class Foobar; end
class User; end

describe OmniAuthenticator do
  let(:auth){ {'provider' => 'foobar', 'uid' => '42'} }
  let(:new_user){ OpenStruct.new }
  let(:old_user){ OpenStruct.new }
  let(:foobar){ double('foobar', :user => old_user, :build_user => new_user) }

  subject { OmniAuthenticator.new(auth) }

  before :each do
    Foobar.stub(:find_by_uid => foobar)
  end

  it "finds the appropriate way to authenticate" do
    Foobar.should_receive(:find_by_uid).and_return(foobar)
    subject.find_user
  end

  it "finds a User" do
    subject.find_user.should == foobar.user
  end

  it "creates a User" do
    foobar.stub(:user).and_return(nil, new_user)
    foobar.should_receive(:build_user).and_return(new_user)
    foobar.should_receive(:save!).and_return(true)
    subject.find_user.should == new_user
  end

  it "responds to find_something methods" do
    subject.should respond_to(:find_foo_bar)
  end

  it "does not respond to bogus methods" do
    subject.should_not respond_to(:bogus_name)
  end

  it "dispatches method_missing up the chain" do
    lambda{ subject.bogus_name }.should raise_error(NoMethodError)
  end
end
