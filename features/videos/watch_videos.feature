@http://www.pivotaltracker.com/story/show/29514127
Feature: Watch videos
  In order to learn a new technique
  As a user
  I want to watch a video

  Background:
    Given the following videos:
    | name             | url |
    | Omoplata         | b   |
    | Triangle Choke   | d   |
    | Guillotine Choke | f   |

  Scenario: List Videos
    When I am on the videos page
    Then I should see a video item for "Omoplata"
    Then I should see a video item for "Triangle Choke"
    Then I should see a video item for "Guillotine Choke"

  Scenario: Watch a video
    Given I am on the videos page
     When I click on "something"
     Then I should see a video
