@http://www.pivotaltracker.com/story/show/30252465
Feature: Profile page
  In order to tell other users about myself
  As a user
  I want to update my profile

  Scenario: First visit
    Given there are no registered users
    When I register as "alice@example.com" using the password "password"
    Then I should be on the edit account page
    When I fill in the nickname field with "Alice K"
     And I fill in the teacher field with "Vitor 'Shaolin' Ribeiro"
     And I fill in the rank field with "Blue belt"
     And I click on "Update Account"
    Then I should be on my account page
     And I should see "Rank: Blue belt"
     And I should see "Teacher: Vitor 'Shaolin' Ribeiro"
     And I should see "Alice K"
     And I should see "1 visit"
     And I should see "No posts"
     And I should see "No comments"
     # - this needs js...
     # And I should see "Last signed in: less than a minute ago"