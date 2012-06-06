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

  Scenario: Visit my profile
    Given the following user:
    | username      | Alice K                 |
    | sign_in_count | 2                       |
    | teacher       | Vitor 'Shaolin' Ribeiro |
    | rank          | Blue belt               |
    | location      | New York                |
    And the following identity:
    | email    | alice@example.com |
    | password | password          |
    And that identity belongs to that user
    And I am signed in as "alice@example.com" with a password of "password"
    When I visit the home page
     And I click on "My Profile" within the navigation
    Then I should be on my account page
    And I should see "3 visits"



