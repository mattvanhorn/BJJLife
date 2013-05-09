@http://www.pivotaltracker.com/story/show/30341543
Feature: Moderate User Posted Videos
  In order to prevent porn and/or spam
  As an admin
  I want to moderate new videos

  # Cast:
  # Bobby, a user with 2 previous visits
  #
  Scenario: User POV
    Given a user: Bobby
      And I am signed in as Bobby
      And I am on the new video page
     When I add a video
     Then I should see "Your entry is awaiting moderation"
