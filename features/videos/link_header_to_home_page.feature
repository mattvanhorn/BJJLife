@http://www.pivotaltracker.com/story/show/30109673
Feature: Link header to home page
  In order to get back to the homepage
  As a user
  I want to click on the header logo

  Scenario: Default
    Given I am on the videos page
    When I click on "Living BJJ" within the header logo
    Then I should be on the home page
