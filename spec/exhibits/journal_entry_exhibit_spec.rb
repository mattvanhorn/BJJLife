require 'exhibit_spec_helper'
require_relative '../../app/exhibits/journal_entry_exhibit'

describe "JournalEntryExhibits" do
  stub_class 'JournalEntry'
  before { JournalEntry.stub(:new => double(:class => JournalEntry)) }
  subject { JournalEntryExhibit }
  it { should apply_to(JournalEntry.new) }
end

describe "a JournalEntryExhibit" do
  Delegator.class_eval { include RSpec::Mocks::Methods }

  subject        { exhibit }

  let(:context) { Object.new }
  let(:journal_entry) { OpenStruct.new(:title => 'what I learned', :body => 'some stuff') }
  let(:exhibit) { JournalEntryExhibit.new(journal_entry, context) }

  it "renders itself as a link" do
    template = stub(:controller_name => 'journals')
    template.should_receive(:render).with(hash_including(partial: 'journal_entries/link'))
    exhibit.render(template)
  end

  it "renders itself as text" do
    template = stub(:controller_name => 'not_journals')
    exhibit.render(template).should == 'some stuff'
  end
end
