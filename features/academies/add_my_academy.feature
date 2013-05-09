@http://www.pivotaltracker.com/story/show/29884601
Feature: Add my academy
  In order to promote my academy
  As a bjj instructor
  I want to add my academy to the list

  @geocode_academy
  Scenario: US Address
  Given I am on the new academy page
   When I add an academy in the US
   Then I should be on the academies page
    And I should see "Your entry is awaiting moderation"
    And I should not see the academy listed

   When the academy listing is published
    And I go to the academies page
   Then I should see the academy listed

  @geocode_academy_br
  Scenario: Brazil Address
  Given I am on the new academy page
   When I add an academy outside the US
   Then I should be on the academies page
    And I should see "Your entry is awaiting moderation"
    And I should not see the academy listed

   When the academy listing is published
    And I go to the academies page
   Then I should see the academy listed

