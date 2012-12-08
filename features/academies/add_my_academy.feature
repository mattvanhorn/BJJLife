@http://www.pivotaltracker.com/story/show/29884601
Feature: Add my academy
  In order to promote my academy
  As a bjj instructor
  I want to add my academy to the list

  @geocode_academy
  Scenario: US Address
  Given I am on the academies page
    And I should not see "Vitor Shaolin's Brazilian Jiu Jitsu"
   When I follow the add academy link
   Then I should be on the new academy page
   When I fill out the form with:
    | Name            | Vitor Shaolin's Brazilian Jiu Jitsu |
    | Instructor      | Vitor Shaolin                       |
    | Street          | 780 8th Ave                         |
    | Suite/Floor     | 3rd floor                           |
    | City            | New York                            |
    | State/Region    | NY                                  |
    | Postal Code     | 10036                               |
    | Email           | tkd@4blackbelt.com                  |
    | Phone           | (212) 957-4045                      |
    | Website         | http://bjjnewyorkcity.com/          |
   And I click on "Create Academy"
  Then I should be on the academies page
   And I should see "Your entry is awaiting moderation"
  When the academy listing is published
   And I go to the academies page
  Then I should see "Vitor Shaolin's Brazilian Jiu Jitsu"

  @geocode_academy_br
  Scenario: Brazil Address
  Given I am on the academies page
    And I should not see "Nova União (Academia Upper)"
   When I follow the add academy link
   Then I should be on the new academy page
   When I fill out the form with:
    | Name          | Nova União (Academia Upper) |
    | Instructor    | André Pederneires           |
    | Street        | Rua Marques de Abrante, 88  |
    | City          | Rio de Janeiro              |
    | State/Region  | RJ                          |
    | Postal Code   | 22230-061                   |
    | Country       | Brazil                      |
    | Phone         | (21) 2553 3485              |

   And I click on "Create Academy"
  Then I should be on the academies page
   And I should see "Your entry is awaiting moderation"
  When the academy listing is published
   And I go to the academies page
  Then I should see "Nova União (Academia Upper)"
