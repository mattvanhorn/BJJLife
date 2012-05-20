@http://www.pivotaltracker.com/story/show/29649945
Feature: View signups
  In order to evaluate my campaigns
  As an admin
  I want to see a list of subscriptions

  Scenario: View all
    Given the following subscriptions:
    | email             |
    | alice@example.com |
    | bob@example.com   |
    | carol@example.com |
    And I perform HTTP authentication as "admin/password"
    When I am on the admin subscriptions page
    Then I should see "alice@example.com"
     And I should see "bob@example.com"
     And I should see "carol@example.com"
