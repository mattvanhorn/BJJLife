@http://www.pivotaltracker.com/story/show/31698221
Feature: Markets
  In order to display relevant products to users
  As an admin
  I want to assign products to markets

  Background:
    Given a product with a market and category

  Scenario: Products in user's market are visible
   Given a signed-in user in that market
    When they go to the products page
    Then they should see that product

  Scenario: Products not in user's market are hidden
    Given a signed-in user in a different market
     When they go to the products page
     Then they should not see that product

  Scenario: users in unknown markets see everything
    Given a signed-in user with no market
    When they go to the products page
    Then they should see that product


