@http://www.pivotaltracker.com/story/show/30612163
Feature: Post comments
  In order to add value to the post and raise my status
  As a user
  I want to comment on the post

  # Cast:
  # Bobby, a returning user with 2 previous visits
  #
  Background:
    Given the following blog:
      | title | Training Tips |

      And that blog has the following posts:
      | title             | url                              | description                  |
      | A blog post       | http://www.example.com/article/1 | this is a great article      |
      | Another blog post | http://www.example.com/article/2 | this is also a great article |
      And a user: Bobby
      And I am signed in as Bobby
      And I am on the training tips page

  Scenario: Enter a comment
    When I add a comment to the first post
    Then I should be on the post page for that comment
     And I should see that comment
