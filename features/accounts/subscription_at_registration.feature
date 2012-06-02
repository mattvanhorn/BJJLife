@http://www.pivotaltracker.com/story/show/30568069
Feature: Subscription at registration
  In order to receive site announcements if I want them
  As a user
  I want to manage my subscription status at registration time

  Scenario: Opt-out (by default)
    Given there are no registered users
      And there are no subscriptions
     When I visit the sign up page
      And I fill in "Email" with "alice@example.com"
      And I fill in "Password" with "password"
      And I fill in "Confirm password" with "password"
      And I click on "Sign Up" within the new account form
     Then there should not be a subscription for "alice@example.com"

  Scenario: Opt-out (by default)
    Given there are no registered users
      And there are no subscriptions
     When I visit the sign up page
      And I fill in "Email" with "alice@example.com"
      And I fill in "Password" with "password"
      And I fill in "Confirm password" with "password"
      And I check "subscribe for announcements"
      And I click on "Sign Up" within the new account form
     Then there should be a subscription for "alice@example.com"




