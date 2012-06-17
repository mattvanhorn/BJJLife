@http://www.pivotaltracker.com/story/show/30341543
Feature: Moderate User Posted Videos
  In order to prevent porn and/or spam
  As an admin
  I want to moderate new videos

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
    And I am signed in as "alice@example.com" with a password of "seekrit"

  Scenario: User POV
    Given I am on the new video page
     When I add a video
     Then I should see "Your entry is awaiting moderation"
