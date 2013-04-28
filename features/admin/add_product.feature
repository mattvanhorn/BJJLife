@http://www.pivotaltracker.com/story/show/31395117 @admin
Feature: Admin Add Product
  In order to sell stuff
  As an admin
  I want to add a product

  @vcr
  Scenario:
    Given I perform HTTP authentication as "admin/password"
      And there are no products
     When I add a product
   Then I should be on the products admin page
    And I should see the product I added
