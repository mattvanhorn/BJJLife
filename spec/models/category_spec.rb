# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
# Indexes
#
#  index_categories_on_name  (name) UNIQUE
#

require 'spec_helper'

describe Category do
  include NullDB::RSpec::NullifiedDatabase

  let(:category){ Category.new }

  it "has a name" do
    category.name = 'foo'
    category.name.should == 'foo'
  end

  it { should validate_presence_of(:name) }

  it "validates the uniquenes of name" do
    Category.validators_on(:name).select{|v|v.is_a? (ActiveRecord::Validations::UniquenessValidator)}.should_not be_empty
    # TEMPORARILY REMOVE INDEX CHECK PENDING FIXES TO NULLDB
    # subscription.should have_db_index(:name).unique(true)
  end
end
