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

  Scenario: View a product
    When I go to the products page
    Then I should see "foo"
    And I should see "$10.00"
    And I should see a link to the product detail page for the product named "foo"
    And I should see a link to buy the product named "foo"

    And I should see "bar"
    And I should see "$15.00"
    And I should see a link to "/products/2"
    And I should see a link to "/products/2/orders/new"

    And I should see "baz"
    And I should see "$20.00"
    And I should see a link to "/products/3"
    And I should see a link to "/products/3/orders/new"
