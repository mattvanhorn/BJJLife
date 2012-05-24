@http://www.pivotaltracker.com/story/show/29884601
Feature: Add my academy
  In order to promote my academy
  As a bjj instructor
  I want to add my academy to the list

  Scenario:
  Given I am on the academies page
    And I should not see "Vitor Shaolin's Brazilian Jiu Jitsu"
   When I follow the add academy link
   Then I should be on the new academy page
   When I fill out the form with:
    | Name         | Vitor Shaolin's Brazilian Jiu Jitsu |
    | Instructor   | Vitor Shaolin                       |
    | Street       | 780 8th Ave                         |
    | Unit         | 3rd floor                           |
    | City         | New York                            |
    | State        | NY                                  |
    | ZIP Code     | 10036                               |
    | Email        | tkd@4blackbelt.com                  |
    | Phone        | (212) 957-4045                      |
    | Website      | http://bjjnewyorkcity.com/          |
   And I click on "Create Academy"
  Then I should be on the academies page
   And I should see "Vitor Shaolin's Brazilian Jiu Jitsu"
