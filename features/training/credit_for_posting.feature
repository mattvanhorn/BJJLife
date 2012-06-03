@http://www.pivotaltracker.com/story/show/30601621
Feature: Credit for posting
  In order to boost my ego
  As a user
  I want to see my username attached to the posts I make

  Background:
    Given the following blog:
      | title | Training Tips |

    And the following identity:
      | email                 | alice@example.com |
      | password              | seekrit           |

    And the following user:
      | username      | alicek |
      | sign_in_count | 2      |

    And that identity belongs to that user

  Scenario: Posting requires sign in
    Given I am not signed in
    When I go to the training tips page
     And I click on "New Post"
    Then I should be on the sign in page

  Scenario: New post gets credit
    Given I am signed in as "alice@example.com" with a password of "seekrit"
    When I go to the training tips page
     And I click on "New Post"
     And I fill in "Title" with "Some Great Article"
     And I fill in "URL" with "http://www.example.com"
     And I fill in "Description" with "This is a really great article."
     And I click on "Create Post"
    Then I should be on the training tips page
     And I should see "Some Great Article"
     And I should see "posted by alicek"
