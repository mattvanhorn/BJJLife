@http://www.pivotaltracker.com/story/show/30693521
Feature: Vote on video
  In order to see better content
  As a user
  I want to upvote and downvote videos

  Background:
   Given I am signed in as a user with 2 previous visits

  Scenario: Videos ranked by 95% confidence interval of lower bound of positive votes
   Given the following videos:
     | id | name       | url                                | up_votes | down_votes |
     | 1  | good video | http://www.youtube.com/example?v=2 | 10       | 5          |
     | 2  | bad video  | http://www.youtube.com/example?v=3 | 0        | 10         |
     | 3  | best video | http://www.youtube.com/example?v=1 | 20       | 10         |
     | 4  | new video  | http://www.youtube.com/example?v=4 | 0        | 0          |
    When I visit the videos page
    Then "best video" should appear before "good video"
     And "good video" should appear before "bad video"

  Scenario: Upvoting
  Given the following videos:
    | id | name         | url                                | up_votes | down_votes |
    | 1  | good video   | http://www.youtube.com/example?v=2 | 10       | 9          |
    | 2  | better video | http://www.youtube.com/example?v=2 | 11       | 10         |
    When I visit the videos page
    Then "good video" should appear before "better video"
    When I like the video "better video"
    Then "better video" should appear before "good video"

  Scenario: Downvoting
  Given the following videos:
    | id | name        | url                                | up_votes | down_votes |
    | 1  | bad video   | http://www.youtube.com/example?v=2 | 9        | 10         |
    | 2  | worse video | http://www.youtube.com/example?v=2 | 10       | 11         |
    When I visit the videos page
    Then "worse video" should appear before "bad video"
    When I hate the video "worse video"
    Then "bad video" should appear before "worse video"
