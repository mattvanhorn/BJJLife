@http://www.pivotaltracker.com/story/show/30252465
Feature: Profile page
  In order to tell other users about myself
  As a user
  I want to update my profile

  Scenario: First visit
    Given there are no registered users
    When I sign up
    Then I should be on the edit account page

    When I update my profile
    Then I should be on my account page
     And I should see my profile details
     And I should see "No posts"
     And I should see "No comments"

  Scenario: Visit my profile
    Given I am signed in as a user
     When I navigate to "My Profile"
     Then I should be on my account page

  Scenario: Previous visits
    Given I am signed in as a user with 2 previous visits
     When I visit my account page
     Then I should see "3 visits"
