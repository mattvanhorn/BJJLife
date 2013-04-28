# == Schema Information
#
# Table name: markets
#
#  id        :integer          not null, primary key
#  name      :string(255)
#  parent_id :integer
#  lft       :integer          not null
#  rgt       :integer          not null
#  depth     :integer          default(0), not null
#
# Indexes
#
#  index_markets_on_parent_id  (parent_id)
#

require 'spec_helper'

describe Market do
  let(:market){ Market.new }
  subject { market }

  describe "class" do
    let(:new_york)  { Market.new(:name => 'New York') }
    let(:boston)    { Market.new(:name => 'Boston') }
    before do
      stub_class 'Location'
    end
    it "gets nearby markets" do
      Location.stub_chain(:where, :near).and_return([double('market', :locatable => new_york),double('market', :locatable => boston)])
      Market.near(Location.new).should == [new_york, boston]
    end
  end

end
