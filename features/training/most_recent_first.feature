@http://www.pivotaltracker.com/story/show/30311815
Feature: Most recent posts show up first
  In order to easily notice new content
  As a user
  I want to see the most recent posts first

  Scenario: Default
    Given the following blog:
      | title | Training Tips |

      And that blog has the following posts:
      | title                | url                              | description                   | created_at |
      | An older blog post   | http://www.example.com/article/1 | this is a great article       | 2012-04-30 |
      | A very old blog post | http://www.example.com/article/2 | this is a great article       | 2012-03-30 |
      | A recent blog post   | http://www.example.com/article/3 | this is a more recent article | 2012-05-30 |

     When I go to the training tips page

     Then "A recent blog post" should appear before "An older blog post"
     And "An older blog post" should appear before "A very old blog post"
