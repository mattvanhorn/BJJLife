@http://www.pivotaltracker.com/story/show/30109673
Feature: Link header to home page
  In order to get back to the homepage
  As a user
  I want to click on the site logo

  Scenario: Default
    Given I am on the videos page
    When I click on the site logo
    Then I should be on the home page
