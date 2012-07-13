@http://www.pivotaltracker.com/story/show/30824595
Feature: Make a purchase
  In order to show my support for the site
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
    Then I should see "foobar"
    And I should see "$10.00"

  @javascript @stripe
  Scenario: Register at checkout
    Given there are no registered users
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

  @javascript
  Scenario: Sign in at checkout
    Given the following user:
      | username      | alice |
      | sign_in_count | 2     |
      And the following identity:
      | email    | alice@example.com |
      | password | seekrit           |
      And that identity belongs to that user
      And I am not signed in
     When I go to the product page for that product
      And I click on "Buy Now!"
      And I click on "sign in"
      And I enter the following information into the form:
        | Email    | alice@example.com |
        | Password | seekrit           |
      And I click on "Sign In" within the form
     Then I should be on the checkout page

  @javascript @stripe
  Scenario: Purchase a product
    Given I register as "alice@example.com" using the password "seekrit"
     When I go to the product page for that product
      And I click on "Buy Now!"
     When I enter the following information into the form:
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

  @javascript
  Scenario: Bad Card Info
    Given I register as "alice@example.com" using the password "seekrit"
     When I go to the product page for that product
      And I click on "Buy Now!"
     When I enter the following information into the form:
      | First Name         | Alice   |
      | Last Name          | Kramden |
      | Credit Card Number | foobar  |
      | CVV                | 123     |
      | cc_exp_month       | 1 - Jan |
      | cc_exp_year        | 2020    |
      And I place the order
      Then I should be on the checkout page
      And I should see "This card number looks invalid"

  @javascript
  Scenario: Duplicate Email
    Given I register as "alice@example.com" using the password "seekrit"
      And I am not signed in
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
     Then I should be on the checkout page with errors
      And I should see "has already been taken" within the email input
