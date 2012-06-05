@http://www.pivotaltracker.com/story/show/30311811
Feature: User registration
  In order to get credit for my great posts
  As a user
  I want to register my identity

  Scenario: Registration
    Given there are no registered users
     When I visit the sign up page
      And I fill in "Email" with "alice@example.com"
      And I fill in "Password" with "password"
      And I fill in "Confirm password" with "password"
      And I click on "Sign Up" within the new account form
     Then I should be on the edit account page
     When I fill in the nickname field with "Alice K"
      And I click on "Update Account"
     Then I should be on my account page
      And I should see "Alice K"


