require 'exhibit_spec_helper'
require_relative '../../app/exhibits/contributor_exhibit'

describe "ContributorExhibit" do
  stub_class 'Post'
  stub_class 'Comment'
  subject { ContributorExhibit }
  it { should apply_to(Post.new) }
  it { should apply_to(Comment.new) }
end

describe ContributorExhibit do

  subject        { exhibit }

  let(:context)  { Object.new }
  let(:user)     { Object.new }
  let(:comment)  { OpenStruct.new(:user => user) }

  let(:exhibit)  { ContributorExhibit.new(comment, context) }

  it "gets a username when it exists" do
    user.stub(:username => 'Phil')
    exhibit.contributor.should == 'Phil'
  end

  it "uses 'anonymous' when no username exists" do
    user.stub(:username => nil)
    exhibit.contributor.should == 'anonymous'
  end
end
