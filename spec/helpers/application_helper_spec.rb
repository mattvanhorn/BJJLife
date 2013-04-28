require 'spec_helper'

describe ApplicationHelper do


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

  describe "#stripe_javascript" do
    before(:each) do
      helper.controller.stub(:controller_name => 'orders')
    end

    it "shows up on orders controller views" do
      helper.stripe_javascript.should == javascript_include_tag("https://js.stripe.com/v1/", :defer => 'defer')
    end
    it "doesn't show up on other controller views" do
      helper.controller.stub(:controller_name => 'foobar')
      helper.stripe_javascript.should be_nil
    end
  end

  describe "#order_form_javascript" do
    it "has content on the orders controller" do
      helper.controller.stub(:controller_name => 'orders')
      helper.order_form_javascript.should_not be_blank
    end

    it "is blank on other controllers" do
      helper.controller.stub(:controller_name => 'something_else')
      helper.order_form_javascript.should be_blank
    end
  end

  describe "#products_page_javascript" do
    it "has content on the products controller index action" do
      helper.controller.stub(:controller_name => 'products', :action_name => 'index')
      helper.products_page_javascript.should_not be_blank
    end

    it "is blank on other controllers" do
      helper.controller.stub(:controller_name => 'academies', :action_name => 'index')
      helper.products_page_javascript.should be_blank
    end
    it "is blank on other actions" do
      helper.controller.stub(:controller_name => 'products', :action_name => 'show')
      helper.products_page_javascript.should be_blank
    end
  end
end
