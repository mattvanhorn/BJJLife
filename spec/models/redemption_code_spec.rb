# == Schema Information
#
# Table name: redemption_codes
#
#  id            :integer         not null, primary key
#  order_item_id :integer         not null
#  token         :string(255)     not null
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#
# Indexes
#
#  index_redemption_codes_on_order_item_id  (order_item_id)
#

require 'spec_helper'

describe RedemptionCode do
  include NullDB::RSpec::NullifiedDatabase

  let(:redemption_code){ RedemptionCode.new() }

  it "sets a token at init" do
    redemption_code.token.should_not be_nil
  end

  it "displays as a string" do
    redemption_code.to_s.should == redemption_code.token
  end

  it "generates unique tokens" do
    actual = []
    1000.times do
      actual << RedemptionCode.new.to_s
    end
    actual.uniq.should == actual
  end

end
