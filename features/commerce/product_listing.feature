@http://www.pivotaltracker.com/story/show/31337027
Feature: Product Listing
  In order to quickly find the products I'm interested in
  As a site user
  I want a product list page

  Background:
    Given the following products:
    | name | price | photo     |
    | foo  | 1000  | sloth.jpg |
    | bar  | 1500  | sloth.jpg |
    | baz  | 2000  | sloth.jpg |

  Scenario: View a product
    When I go to the products page
    Then I should see "foo"
    And I should see "$10.00"
    Then I should see "bar"
    And I should see "$15.00"
    Then I should see "baz"
    And I should see "$20.00"
