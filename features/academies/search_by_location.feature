@https://www.pivotaltracker.com/story/show/29883881
Feature: Search by location
  In order to find an academy near me
  As a user
  I want to search by location

  Background:
    Given the following academies:
    | id | name                                | email              | phone_number   | website                      |
    | 1  | Vitor Shaolin's Brazilian Jiu Jitsu | tkd@4blackbelt.com | (212) 957-4045 | http://bjjnewyorkcity.com/   |
    | 2  | Ralph Gracie SF                     |                    | (415) 552-4777 | http://www.ralphgraciesf.com |
    And the following academy locations:
    | locatable_id | locatable_type | street          | unit      | city          | us_state | postal_code | lat    | lng      |
    | 1            | Academy        | 780 8th Ave     | 3rd floor | New York      | NY       | 10036       | 40.753 | -73.999  |
    | 2            | Academy        | 1166 Howard St. |           | San Francisco | CA       | 94103       | 37.805 | -122.410 |

  @geocode_search_sf
  Scenario: Find by zip code
    Given I am on the academies page
    When I fill in "Location" with "94133"
     And I click on "Search"
    Then I should see "Ralph Gracie"
     And I should not see "Shaolin"

  @geocode_search_ny
  Scenario: Find by city and state
    Given I am on the academies page
     When I fill in "Location" with "New York, NY"
      And I click on "Search"
     Then I should see "Shaolin"
      And I should not see "Ralph Gracie"
