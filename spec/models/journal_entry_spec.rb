require 'spec_helper'

describe JournalEntry do
  subject(:entry){ JournalEntry.new }
  it { should belong_to(:journal) }

  it "has a title" do
    entry.title = 'foo'
    entry.title.should == 'foo'
  end

  it "has a body" do
    entry.body = 'foo'
    entry.body.should == 'foo'
  end

  it "has a time stamp" do
    entry.created_at = DateTime.parse("July 4, 2016")
    entry.created_at.should == DateTime.parse("2016-07-04")
  end

  it "has tags" do
    pending
  end

  it "can be shared" do
    pending
  end

  it "can have images" do
    pending
  end

  it "can have video" do
    pending
  end

end
