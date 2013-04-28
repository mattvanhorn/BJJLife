@http://www.pivotaltracker.com/story/show/29885029
Feature: support other video types
  In order to broaden my selection pool for videos
  As an administrator
  I want to be able to upload something other than youtube.

  Background:
    Given I perform HTTP authentication as "admin/password"

  @vimeo
  Scenario: Vimeo videos
    Given I am on the new video admin page
     When I add a vimeo video
     Then I should be on the videos admin page
      And I should see the video I added

  Scenario: Youtube videos
    Given I am on the new video admin page
     When I add a youtube video
     Then I should be on the videos admin page
      And I should see the video I added
