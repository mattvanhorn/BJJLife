@http://www.pivotaltracker.com/story/show/30824595
Feature: Make a purchase
  In order to show my support for the site
  As a site user
  I want to buy a product

  # Background:
  #   Given the following product:
  #   | name  | foobar    |
  #   | price | 1000      |
  #   | photo | sloth.jpg |
  #   And there are no orders
  #
  # Scenario: View a product
  #   When I go to the product page for that product
  #   Then I should see "foobar"
  #   And I should see "$10.00"

  @javascript @wip
  Scenario: Register during checkout
    Given the following product:
    | name  | foobar    |
    | price | 1000      |
    | photo | sloth.jpg |
     When I go to the product page for that product
     And I click on "Buy Now!"
    When I enter the following information into the form:
    | Email              | alice@example.com     |
    | Password           | seekrit               |
    | Confirm password   | seekrit               |
    | First Name         | Alice                 |
    | Last Name          | Kramden               |
    | Credit Card Number | 4242424242424242      |
    | CVV                | 123                   |
    | cc_exp_month       | 1 - Jan               |
    | cc_exp_year        | 2020                  |
    | Street             | 1313 Mockingbird Lane |
    | Apt                | 42                    |
    | City               | Gotham                |
    | State              | NY                    |
    | ZIP Code           | 12345                 |
    And I place the order
    Then I should be on the order confirmation page
     And I should see "foobar"
     And I should see "1 @ $10.00"
     And I should see "Total: $10.00"
  #
  # @wip
  # Scenario: Sign in during checkout
  #   Given context
  #   When event
  #   Then outcome
  #
  # @wip
  # Scenario: Purchase a product
  #   When I go to the product page for that product
  #   And I click on the buy button
  #   Then I should be on the checkout page
  #
  #   When I enter the following information into the form
  #   |  |  |
  #   And I click on the checkout button
  #   Then I should be on the purchase thank you page
  #   And I should receive a purchase confirmation email
  #   And there should be 1 successful order
  #
  # @wip
  # Scenario: Failed purchase
  #   When I go to the product page for that product
  #   And I click on the buy button
  #   Then I should be on the checkout page
  #
  #   When I enter the following information into the form
  #   |  |  |
  #   And I click on the checkout button
  #   Then I should be on the checkout page
  #   And I should see "Error: something..."
  #   And I should not receive a purchase confirmation email
  #   And there should be 1 failed order
