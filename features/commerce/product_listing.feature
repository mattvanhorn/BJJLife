@http://www.pivotaltracker.com/story/show/31337027
Feature: Product Listing
  In order to quickly find the products I'm interested in
  As a site user
  I want a product list page

  Background:
    Given the following products:
    | id | name | price | photo     |
    | 1  | foo  | 1000  | sloth.jpg |
    | 2  | bar  | 1500  | sloth.jpg |
    | 3  | baz  | 2000  | sloth.jpg |
    And 1 category
    And those products belong to that category

  Scenario: View basic info for products: name, price, link to details and buy button
    When I go to the products page
    Then I should see basic info for all the products

