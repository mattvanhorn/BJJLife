@http://www.pivotaltracker.com/story/show/30568069
Feature: Subscription at registration
  In order to receive site announcements if I want them
  As a user
  I want to manage my subscription status at registration time

  # Cast:
  # Alice, a new user
  #
  Background:
    Given I am playing the role: Alice

  Scenario: Opt-out (by default)
     When I sign up without opting in to a subscription
     Then I should not be subscribed

  Scenario: Opt-in
     When I sign up and opt in to a subscription
     Then I should be subscribed
