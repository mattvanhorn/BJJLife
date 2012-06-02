@http://www.pivotaltracker.com/story/show/30595069
Feature: Sign in
  In order to get credit for my contributions
  As a user
  I want to sign in

  Background:
    Given the following user:
    | username      | alice |
    | sign_in_count | 2     |
    And the following identity:
    | email    | alice@example.com |
    | password | password          |
    And that identity belongs to that user
    And I am not signed in

  Scenario: Normal
     When I visit the sign in page
      And I fill in "Email" with "alice@example.com"
      And I fill in "Password" with "password"
      And I click on "Sign In" within the form
     Then I should be on the home page
      And I should see "Hi alice,"

  Scenario: No password
     When I visit the sign in page
      And I fill in "Email" with "alice@example.com"
      And I click on "Sign In" within the form
     Then I should be on the sign in page
      And I should see the missing password message

  Scenario: No email
     When I visit the sign in page
      And I fill in "Password" with "password"
      And I click on "Sign In" within the form
     Then I should be on the sign in page
      And I should see the missing email message

  Scenario: blank form
     When I visit the sign in page
      And I click on "Sign In" within the form
     Then I should be on the sign in page
      And I should see the missing email and password message

  Scenario: Invalid credentials
     When I visit the sign in page
      And I fill in "Email" with "wrong@example.com"
      And I fill in "Password" with "alsowrong"
      And I click on "Sign In" within the form
     Then I should be on the sign in page
      And I should see the invalid credentials message
