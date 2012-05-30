require 'spec_helper'

describe ApplicationHelper do

  it "should not reek" do
    File.open(__FILE__).should_not reek
  end

  describe "full_us_state_name" do
    it "converts known abbreviations" do
      helper.full_us_state_name('NY').should == 'New York'
      helper.full_us_state_name('CA').should == 'California'
    end

    it "handles lowercase abbreviations" do
      helper.full_us_state_name('ak').should == 'Alaska'
    end

    it "returns the argument if unknown" do
      helper.full_us_state_name('Foo').should == 'Foo'
    end
  end
end
