@http://www.pivotaltracker.com/story/show/29506225
Feature: Home page
  In order to know what the site is about
  As a user
  I want to visit the home page

  Scenario: Pre Launch
    When I visit the home page
    Then I should be on the home page
    And I should see "Living BJJ"
