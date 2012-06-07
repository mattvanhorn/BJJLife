require 'spec_helper'

describe CommentDecorator do
  let(:comment) { mock_model(Comment, :user => double('user', :username => 'alicek')) }
  subject { CommentDecorator.decorate(comment) }

  it "should not reek" do
    get_source_file(__FILE__).should_not reek
  end

  it "finds the username for attribution" do
    subject.contributor.should == 'alicek'
  end

  it "plays nice with haml" do
    subject.haml_object_ref.should == 'comment'
  end
end
