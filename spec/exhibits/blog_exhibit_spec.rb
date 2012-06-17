require 'exhibit_spec_helper'
require_relative '../../app/exhibits/blog_exhibit'

describe "BlogExhibit" do
  stub_class 'Blog'
  subject { BlogExhibit }
  it { should apply_to(Blog.new) }
end

describe BlogExhibit do
  Delegator.class_eval { include RSpec::Mocks::Methods }

  subject        { exhibit }

  let(:context)  { Object.new }
  let(:blog)     { OpenStruct.new(:entries => entries) }
  let(:entries)  { Object.new }

  let(:exhibit)  { BlogExhibit.new(blog, context) }

  it 'exhibits its entries' do
    exhibited_entries = Object.new
    exhibit.should_receive(:exhibit).with(entries).and_return(exhibited_entries)
    exhibit.entries.should equal(exhibited_entries)
  end

end
