require 'exhibit_spec_helper'
require_relative '../../app/exhibits/journal_exhibit'

describe "JournalExhibits" do
  stub_class 'Journal'
  before { Journal.stub(:new => double(:class => Journal)) }
  subject { JournalExhibit }
  it { should apply_to(Journal.new) }
end

describe "a JournalExhibit" do
  Delegator.class_eval { include RSpec::Mocks::Methods }

  subject        { exhibit }

  let(:context) { Object.new }
  let(:entries) { [Object.new] }
  let(:journal) { OpenStruct.new(:name => 'My Journal', :entries => entries) }
  let(:exhibit) { JournalExhibit.new(journal, context) }

  it 'exhibits its entries' do
    exhibited_entries = []
    exhibit.should_receive(:exhibit).with(entries).and_return(exhibited_entries)
    exhibit.entries.should equal(exhibited_entries)
  end
end
