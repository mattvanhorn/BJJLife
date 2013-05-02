@http://www.pivotaltracker.com/story/show/30311811
Feature: User registration
  In order to get credit for my great posts
  As a user
  I want to register my identity

  Scenario: Registration
    Given there are no registered users
     When I sign up
      And I visit the home page
     Then I should see "Sign Out"
