# == Schema Information
#
# Table name: markets
#
#  id        :integer         not null, primary key
#  name      :string(255)
#  parent_id :integer
#  lft       :integer         not null
#  rgt       :integer         not null
#  depth     :integer         default(0), not null
#
# Indexes
#
#  index_markets_on_parent_id  (parent_id)
#

require 'spec_helper'

describe Market do
  let(:market){ Market.new }
  subject { market }

end
