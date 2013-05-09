@http://www.pivotaltracker.com/story/show/30824595
Feature: Make a purchase
  In order to get some cool gear
  As a site user
  I want to buy a product

  # Cast:
  # Alice, a new user
  # Bobby, a returning user with 2 previous visits
  #
  Background:
    Given the following category:
    | name | frobnitzes |
    And the following product:
    | name  | foobar    |
    | price | 1000      |
    | photo | sloth.jpg |
    And that product belongs to that category
    And a user: Bobby

  Scenario: View a product
   Given I am playing the role: Alice
    When I go to the product page for that product
    Then I should see the product details

  @javascript @stripe
  Scenario: Register at checkout
    Given I am playing the role: Alice
     When I buy that product
      And I enter my registration info
      And I enter my credit card info
      And I enter my address info
      And I place the order
     Then I should have an order confirmation

  @javascript
  Scenario: Sign in at checkout
    Given I am playing the role: Bobby
      And I am not signed in
     When I buy that product
      And I sign in
     Then I should be on the checkout page

  @javascript @stripe
  Scenario: Purchase a product
    Given I am signed in as Bobby
     When I buy that product
      And I enter my credit card info
      And I enter my address info
      And I place the order
     Then I should have an order confirmation

  @javascript
  Scenario: Bad Card Info
    Given I am signed in as Bobby
     When I buy that product
      And I enter bad credit card info
      And I place the order
     Then I should be on the checkout page
      And I should see "This card number looks invalid"

  @javascript
  Scenario: Duplicate Email
    Given I am not signed in
     When I buy that product
      And I try to register with an email that is already used
      And I enter my credit card info
      And I enter my address info
      And I place the order
     Then I should see "Email has already been taken" on the failed checkout page
