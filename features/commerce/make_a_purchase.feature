@http://www.pivotaltracker.com/story/show/30824595
Feature: Make a purchase
  In order to get some cool gear
  As a site user
  I want to buy a product

  Background:
    Given the following category:
    | name | frobnitzes |
    And the following product:
    | name  | foobar    |
    | price | 1000      |
    | photo | sloth.jpg |
    And that product belongs to that category
    And there are no orders

  Scenario: View a product
    When I go to the product page for that product
    Then I should see the product details

  @javascript @stripe
  Scenario: Register at checkout
    Given there are no registered users
     When I buy that product
      And I enter my registration info
      And I enter my credit card info
      And I enter my address info
      And I place the order
     Then I should have an order confirmation

  @javascript
  Scenario: Sign in at checkout
    Given a returning user
      And I am not signed in
     When I buy that product
      And I sign in as that user
     Then I should be on the checkout page

  @javascript @stripe
  Scenario: Purchase a product
    Given I am signed in as a user with 2 previous visits
     When I buy that product
      And I enter my credit card info
      And I enter my address info
      And I place the order
     Then I should have an order confirmation

  @javascript
  Scenario: Bad Card Info
    Given I am signed in as a user with 2 previous visits
     When I buy that product
      And I enter bad credit card info
      And I place the order
     Then I should be on the checkout page
      And I should see "This card number looks invalid"

  @javascript
  Scenario: Duplicate Email
    Given a returning user
      And I am not signed in
     When I buy that product
      And I try to register with an email that is already used
      And I enter my credit card info
      And I enter my address info
      And I place the order
     Then I should see "Email has already been taken" on the failed checkout page
