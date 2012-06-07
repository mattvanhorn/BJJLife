require 'spec_helper'

describe ApplicationHelper do

  it "should not reek" do
    get_source_file(__FILE__).should_not reek
  end

  describe "#full_us_state_name" do
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

  describe "#standard_header" do
    before(:each) do
      helper.extend Haml
      helper.extend Haml::Helpers
      helper.send :init_haml_helpers
    end

    it "works with defaults" do
      helper.should_receive(:t).with(".header").and_return('default text')
      helper.standard_header.should == "<div class='row header'>\n  <h2>default text</h2>\n</div>\n"
    end

    it "works with text" do
      helper.standard_header('foo').should == "<div class='row header'>\n  <h2>foo</h2>\n</div>\n"
    end

    it "works with a block" do
      helper.standard_header('foo'){ helper.haml_tag(:p, 'bar') }.should ==
      "<div class='row header'>\n  <h2>foo</h2>\n  <p>bar</p>\n  \n</div>\n"
    end
  end
end

