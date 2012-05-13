@http://www.pivotaltracker.com/story/show/29508443
Feature: A/B Testing
  In order to optimize my landing page
  As a business owner
  I want to A/B test different text

  Scenario: Default
  When I go to the landing page for option a
  Then I should see the original landing page text
  When I go to the landing page for option b
  Then I should see the new landing page text
