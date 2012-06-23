@http://www.pivotaltracker.com/story/show/31698221
Feature: Markets
  In order to display relevant products to users
  As an admin
  I want to assign products to markets

  Background:
    Given a signed-in user
    And 1 market
    And 1 product
    And 1 category
    And that product belongs to that market
    And that product belongs to that category

  Scenario: Products in user's market are visible
    Given that user belongs to that market
    When they go to the products page
    Then they should see that product

  Scenario: Products in not user's market are not visible
    Given 1 different market
    And that user belongs to that different market
    When they go to the products page
    Then they should not see that product

  Scenario: users in unknown markets see everything
    Given that user's market is unknown
    When they go to the products page
    Then they should see that product


