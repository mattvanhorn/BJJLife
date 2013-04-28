@http://www.pivotaltracker.com/story/show/29868951
Feature: Add video
  In order to improve the user experience
  As an admin
  I want to add a video

  Scenario: Adding a youtube video
  Given I perform HTTP authentication as "admin/password"
    And I visit the new video admin page
    And I add a video
   Then I should be on the videos admin page
    And I should see the video I added
