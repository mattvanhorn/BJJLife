@http://www.pivotaltracker.com/story/show/29885029
Feature: support other video types
  In order to broaden my selection pool for videos
  As an administrator
  I want to be able to upload something other than youtube.

  @vcr
  Scenario: Vimeo videos
    Given I am on the new admin video page
    When I fill in "Name" with "BJJ European Championships 2011"
    And I fill in "Url" with "http://vimeo.com/19850565"
    And I click on "Create Video"
   Then I should be on the admin videos page
    And I should see "BJJ European Championships 2011"

  Scenario: Youtube videos
    Given I am on the new admin video page
    When I fill in "Name" with "Mitsuyo Maeda: The Origin of BJJ"
    And I fill in "Url" with "http://www.youtube.com/watch?v=m0fH_8kv7ac"
    And I click on "Create Video"
   Then I should be on the admin videos page
    And I should see "Mitsuyo Maeda: The Origin of BJJ"
