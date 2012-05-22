@http://www.pivotaltracker.com/story/show/29968253
Feature: delete videos
  In order to not show videos that have been pulled from Youtube
  as an admin
  I want to delete a video

  Scenario: Default
    Given the following videos:
    | id   | name                                             | url                                        |
    | 1001 | Kron Gracie vs Vitor Estima World Jiu Jitsu Expo | http://www.youtube.com/watch?v=uHq5YjQBWNg |
    | 1002 | Jeff Glover vs Caio Terra World Jiu Jitsu Expo   | http://www.youtube.com/watch?v=Z7eixxm5CLI |
    | 1003 | Kyra Gracie vs Alexis Davis World Jiu Jitsu expo | http://www.youtube.com/watch?v=BzYwGrR4_kg |
    And I am on the admin videos page
    When I click on "Destroy" within the video 1003 element
     And I accept the confirmation dialog
    Then I should be on the admin videos page
     And I should not see "Kyra Gracie"



