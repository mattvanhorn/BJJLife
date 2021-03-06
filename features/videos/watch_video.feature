@http://www.pivotaltracker.com/story/show/29514127
Feature: Watch videos
  In order to learn a new technique
  As a user
  I want to watch a video

  Background:
    Given the following videos:
    | name                                             | url         |
    | Kron Gracie vs Vitor Estima World Jiu Jitsu Expo | http://www.youtube.com/watch?v=uHq5YjQBWNg |
    | Jeff Glover vs Caio Terra World Jiu Jitsu Expo   | http://www.youtube.com/watch?v=Z7eixxm5CLI |
    | Kyra Gracie vs Alexis Davis World Jiu Jitsu expo | http://www.youtube.com/watch?v=BzYwGrR4_kg |

  Scenario: List Videos
    When I am on the videos page
    Then I should see all the videos


