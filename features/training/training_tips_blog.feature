@http://www.pivotaltracker.com/story/show/30257159
Feature: List training tips blog entries
  In order to learn about training BJJ
  As a user
  I want to read some good articles from around the web

  Scenario: Default
    Given the following blog:
      | title | Training Tips |

      And that blog has the following posts:
      | title             | url                              | description                  |
      | A blog post       | http://www.example.com/article/1 | this is a great article      |
      | Another blog post | http://www.example.com/article/2 | this is also a great article |

     When I go to the training tips page

     Then I should see a blog entry titled "A blog post" and linked to "http://www.example.com/article/1"
      And I should see "this is a great article"
      And I should see a blog entry titled "Another blog post" and linked to "http://www.example.com/article/2"
      And I should see "this is also a great article"
