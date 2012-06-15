require 'display_case'
require 'ostruct'
require_relative '../../app/exhibits/user_exhibit'

describe UserExhibit do

  context "exhibiting a user" do
    let(:context) { Object.new }
    let(:identity){ OpenStruct.new(:email => 'alice@example.com') }
    let(:user)    { OpenStruct.new(:identity => identity, :username => 'Alice')}
    let(:exhibit) { UserExhibit.new(user, context) }

    describe "#greeting" do
      it "greets by name" do
        exhibit.greeting.should == 'Hi Alice,'
      end

      it "greets generically" do
        user.username = nil
        exhibit.greeting.should == 'Hi there,'
      end
    end

    describe "#email" do
      it "delegates to identity" do
        exhibit.email.should == 'alice@example.com'
      end
    end
  end
end

