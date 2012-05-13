@http://www.pivotaltracker.com/story/show/29506911
Feature: Google analytics
  In order to measure my site traffic
  As an admin
  I want to have Google Analytics enabled

  Scenario: Default
    When I go to the home page
    Then I should see the tracking code

  Scenario: Tracking conversions
    When I go to the home page
     And I sign up for the list as "alice@example.com"
    Then I should see the tracking code
     And I should see a conversion

  Scenario: Tracking conversions
    When I go to the home page
     And I sign up for the list as "invalid_email"
    Then I should see the tracking code
     But I should not see a conversion
