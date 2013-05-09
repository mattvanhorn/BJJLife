@http://www.pivotaltracker.com/story/show/30311811
Feature: User registration
  In order to get credit for my great posts
  As a user
  I want to register my identity

  # Cast:
  # Alice, a new user
  #
  Scenario: Registration
    Given I am playing the role: Alice
     When I sign up
      And I visit the home page
     Then I should see "Sign Out"
