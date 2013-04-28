@http://www.pivotaltracker.com/story/show/30595069
@vcr
Feature: Sign in
  In order to get credit for my contributions
  As a user
  I want to sign in

  Background:
    Given I am not signed in

  Scenario: Normal
     When I sign in successfully
     Then I should see a personalized greeting on the home page

  Scenario: No password
     When I sign in without a password
     Then I should see the missing password message on the sign in page

  Scenario: No email
     When I sign in without an email
     Then I should see the missing email message on the sign in page

  Scenario: blank form
     When I sign in without any credentials
     Then I should see the missing email and password message on the sign in page

  Scenario: Invalid credentials
     When I sign in with bad credentials
     Then I should see the invalid credentials message on the sign in page

  Scenario: Redirecting back to page
   Given the following blog:
      | title | Training Tips |
     And I am on the training tips page
    When I sign in successfully
    Then I should be on the training tips page

  Scenario: Sign Out
    Given I sign in successfully
     When I sign out
     Then I should be on the home page
      But I should not see a personalized greeting on the home page
