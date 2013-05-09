@http://www.pivotaltracker.com/story/show/30601621
Feature: Credit for posting
  In order to boost my ego
  As a user
  I want to see my username attached to the posts I make

  # Cast:
  # Bobby, a returning user who has already filled out his profile nickname.
  #
  Background:
    Given a user: Bobby
      And I am playing the role: Bobby
      And the following blog:
      | title | Training Tips |

  Scenario: Posting requires sign in
   Given I am not signed in
    When I go to the new post page
    Then I should be on the sign in page

  Scenario: New post gets credit
    Given I sign in successfully
     When I create a new post
     Then I should be on the training tips page
      And I should see the post I created
