# == Schema Information
#
# Table name: blogs
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Blog do

  let(:new_post) { OpenStruct.new }
  subject { Blog.new.tap{|b|b.post_source = lambda{ new_post }} }

  it "should not reek" do
    get_source_file(__FILE__).should_not reek
  end

  it { should have(0).entries }

  describe "#add_entry" do
    it "adds to the entries collection" do
      entry = double('entry')
      subject.entries.should_receive(:<<).with(entry)
      subject.add_entry(entry)
    end
  end
end
