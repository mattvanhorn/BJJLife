require 'spec_helper'

describe "scopes" do

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
    it "finds all products sorted by category name (and updated_at) with .categorized" do
      cat1 = Fabricate(:category, :name => 'Beta')
      cat2 = Fabricate(:category, :name => 'Alpha')
      cat3 = Fabricate(:category, :name => 'Gamma')
      prd1 = Fabricate(:product, :name => 'product 1', :category => cat1)
      prd2 = Fabricate(:product, :name => 'product 2', :category => cat1)
      prd3 = Fabricate(:product, :name => 'product 3', :category => cat2)
      prd4 = Fabricate(:product, :name => 'product 4', :category => cat2)
      prd5 = Fabricate(:product, :name => 'product 5', :category => cat3)
      Product.categorized.to_a.should == [prd3, prd4, prd1, prd2, prd5]
    end
  end
end