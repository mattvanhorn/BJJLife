@http://www.pivotaltracker.com/story/show/29514127
Feature: Watch videos
  In order to learn a new technique
  As a user
  I want to watch a video

  Background:
    Given the following videos:
    | name | url |
    | a    | b   |
    | c    | d   |
    | e    | f   |

  Scenario: List Videos
    When I am on the videos page
    Then I should see:

  Scenario: Watch a video
    Given I am on the videos page
     When I click on "something"
     Then I should see a video

