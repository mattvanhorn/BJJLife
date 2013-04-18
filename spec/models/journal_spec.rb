require 'spec_helper'

describe Journal do
  let(:journal){ Journal.new }

  it{ should belong_to(:user) }
  it { should have_many(:entries) }

  it "has a name" do
    journal.name = 'foo'
    journal.name.should == 'foo'
  end



end
