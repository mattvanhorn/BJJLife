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
    let!(:cat1) { Fabricate(:category, :name => 'Beta') }
    let!(:cat2) { Fabricate(:category, :name => 'Alpha') }
    let!(:cat3) { Fabricate(:category, :name => 'Gamma') }

    let!(:market1) { Fabricate(:market, :name => 'New York') }
    let!(:market2) { Fabricate(:market, :name => 'San Francisco') }

    let!(:product1) { Fabricate(:product, :name => 'product 1', :category => cat1, :market => market1) }
    let!(:product2) { Fabricate(:product, :name => 'product 2', :category => cat1, :market => market1) }
    let!(:product3) { Fabricate(:product, :name => 'product 3', :category => cat2, :market => market1) }
    let!(:product4) { Fabricate(:product, :name => 'product 4', :category => cat2, :market => market2) }
    let!(:product5) { Fabricate(:product, :name => 'product 5', :category => cat3, :market => market2) }

    it "finds all products sorted by category name (and updated_at) with .categorized" do
      Product.categorized.to_a.should == [product3, product4, product1, product2, product5]
    end

    it "finds all products in a market" do
      Product.in_market(market1).to_a.should =~ [product1, product2, product3]
    end

    it "finds products categorized for a market" do
      Product.categorized_for(market1).to_a.should == [product3, product1, product2]
    end
  end

  describe "For Locatables" do

    let!(:location1){ Fabricate(:academy_location, :us_state => nil, :country => 'Brazil')}
    let!(:location2){ Fabricate(:academy_location, :us_state => nil, :country => 'USA')}
    let!(:location3){ Fabricate(:academy_location, :us_state => 'NY', :country => nil)}
    let!(:location4){ Fabricate(:academy_location, :us_state => 'CA', :country => nil)}

    let!(:academy1){ Fabricate(:academy, :location => location1) }
    let!(:academy2){ Fabricate(:academy, :location => location2) }
    let!(:academy3){ Fabricate(:academy, :location => location3) }
    let!(:academy4){ Fabricate(:academy, :location => location4) }

    it "should order by state" do
      Academy.ordered_by_state.to_a.should == [academy4, academy3]
    end

    it "should order by country" do
      Academy.ordered_by_country.to_a.should == [academy1, academy2]
    end
  end
end

