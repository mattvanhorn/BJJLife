require 'spec_helper'

describe UserDecorator do
  ApplicationController.new.set_current_view_context
  let(:user_with_name){ mock_model(User, :username => 'alice')}
  let(:user_with_no_name){ mock_model(User, :username => nil)}
  it "greets the user by username" do
    UserDecorator.decorate(user_with_name).greeting.should == "<p>Hi alice,</p>"
  end
  
  it "greets users without usernames generically" do
    UserDecorator.decorate(user_with_no_name).greeting.should == "<p>Hi there,</p>"
  end
end
