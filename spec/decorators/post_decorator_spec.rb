require 'spec_helper'

describe PostDecorator do
  let(:post) { mock_model(Post, :user => double('user', :username => 'alicek')) }
  subject { PostDecorator.decorate(post) }

  it "finds the username for attribution" do
    subject.contributor.should == 'alicek'
  end

  it "plays nice with haml" do
    subject.haml_object_ref.should == 'post'
  end
end
