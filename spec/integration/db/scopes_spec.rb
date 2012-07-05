require 'spec_helper'

describe "scopes", :db => true do

  describe "for Category" do
    it "finds categories that are assigned to products with .in_use" do
      cat1 = Fabricate(:category, :name => 'foo')
      cat2 = Fabricate(:category, :name => 'bar')
      cat3 = Fabricate(:category, :name => 'baz')
      Fabricate(:product, :name => 'product 1', :category => cat1)
      Fabricate(:product, :name => 'product 2', :category => cat3)
      Category.in_use.to_a.should == [cat3, cat1]
    end
  end

  describe "for Product" do
    before(:each) do
      @cat1 = Fabricate(:category, :name => 'Beta')
      @cat2 = Fabricate(:category, :name => 'Alpha')
      @cat3 = Fabricate(:category, :name => 'Gamma')

      @market1 = Fabricate(:market, :name => 'New York')
      @market2 = Fabricate(:market, :name => 'San Francisco')

      @product1 = Fabricate(:product, :name => 'product 1', :category => @cat1, :market => @market1)
      @product2 = Fabricate(:product, :name => 'product 2', :category => @cat1, :market => @market1)
      @product3 = Fabricate(:product, :name => 'product 3', :category => @cat2, :market => @market1)
      @product4 = Fabricate(:product, :name => 'product 4', :category => @cat2, :market => @market2)
      @product5 = Fabricate(:product, :name => 'product 5', :category => @cat3, :market => @market2)
    end

    it "finds all products sorted by category name (and updated_at) with .categorized" do
      Product.categorized.to_a.should == [@product3, @product4, @product1, @product2, @product5]
    end

    it "finds all products in a market" do
      Product.in_market(@market1).to_a.should =~ [@product1, @product2, @product3]
    end

    it "finds products categorized for a market" do
      Product.categorized_for(@market1).to_a.should == [@product3, @product1, @product2]
    end
  end
end

