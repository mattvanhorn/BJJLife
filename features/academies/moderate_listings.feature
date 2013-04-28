@http://www.pivotaltracker.com/story/show/30174393
Feature: Moderate Academy Listings
  In order to prevent garbage data and/or spam
  As an admin
  I want to moderate new listings

  Scenario: User POV
    Given I am on the new academy page
     When I add an academy
     Then I should see "Your entry is awaiting moderation"

  Scenario: Admin POV
   Given I am on the new academy page
    When I add an academy
     And I perform HTTP authentication as "admin/password"
     And I go to the academies admin page
    Then I should see "1 academy awaiting moderation"
    When I publish the academy listing
     And I go to the academies page
    Then I should see 1 academy listing
