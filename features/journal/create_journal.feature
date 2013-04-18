@http://www.pivotaltracker.com/story/show/48366223

Feature: Create a Training Journal

  In order to record my progress learning bjj
  As a bjj student
  I want to create a training journal

  # Cast:
  # Bobby, a returning user with 2 previous visits
  #
  Background:
    Given a user: Bobby
      And I am signed in as Bobby

  Scenario: Create a journal
    Given I have no journals
     When I visit the new journal page
      And I create a journal with the following info:
        | name | My BJJ Journal |
     Then I should be on the journal page
      And I should see "My BJJ Journal"

     When I create an entry in my journal
     Then I should see the journal entry
