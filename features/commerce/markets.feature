@http://www.pivotaltracker.com/story/show/31698221
Feature: Markets
  In order to display relevant products to users
  As an admin
  I want to assign products to markets

  # Cast:
  # Alice, a user with no market
  # Carol, a user in the product market
  # David, a user in a different market
  #
  Background:
    Given a product with a market and category
      And the users: Alice, Carol and David

  Scenario: Products in user's market are visible
   Given I am signed in as Carol
    When I go to the products page
    Then I should see that product

  Scenario: Products not in user's market are hidden
    Given I am signed in as David
     When I go to the products page
     Then I should not see that product

  Scenario: users in unknown markets see everything
    Given I am signed in as Alice
     When I go to the products page
     Then I should see that product


