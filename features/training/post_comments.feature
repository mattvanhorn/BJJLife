@http://www.pivotaltracker.com/story/show/30612163
Feature: Post comments
  In order to add value to the post and raise my status
  As a user
  I want to comment on the post

  Background:
    Given the following blog:
      | title | Training Tips |

      And that blog has the following posts:
      | title             | url                              | description                  |
      | A blog post       | http://www.example.com/article/1 | this is a great article      |
      | Another blog post | http://www.example.com/article/2 | this is also a great article |

      And the following identity:
        | email                 | alice@example.com |
        | password              | seekrit           |

      And the following user:
        | username      | alicek |
        | sign_in_count | 2      |

      And I am signed in as "alice@example.com" with a password of "seekrit"
      And I am on the training tips page

  Scenario: Enter a comment
    When I click on "0 comments" within the first post listed
    Then I should be on the post page for the first post
    When I fill in "comment_body" with "yadda yadda"
    And I click on "Create Comment"
    Then I should be on the post page for the first post
    And I should see "yadda yadda"
