@https://www.pivotaltracker.com/story/show/29868951
Feature: Add video
  In order to improve the user experience
  As an admin
  I want to add a video

  Scenario: Getting to the admin page
    Given I am on the admin videos page
    When I click on "Add Video"
    Then I should be on the new admin video page

  Scenario: Adding a youtube video
    Given I am on the new admin video page
    When I fill in "Name" with "Mitsuyo Maeda: The Origin of BJJ"
    And I fill in "Url" with "m0fH_8kv7ac"
    And I click on "Create Video"
   Then I should be on the admin videos page
    And I should see "Mitsuyo Maeda: The Origin of BJJ"