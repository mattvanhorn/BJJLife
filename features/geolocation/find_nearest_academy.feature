@http://www.pivotaltracker.com/story/show/48366217
Feature: Find nearest academy
  In order to start training BJJ
  As a user
  I want to find an academy near me

  Background:
    Given the following academies:
    | id | name                                | email              | phone_number   | website                      |
    | 1  | Vitor Shaolin's Brazilian Jiu Jitsu | tkd@4blackbelt.com | (212) 957-4045 | http://bjjnewyorkcity.com/   |
    | 2  | Ralph Gracie SF                     |                    | (415) 552-4777 | http://www.ralphgraciesf.com |
    And the following academy locations:
    | locatable_id | locatable_type | street          | unit      | city          | us_state | postal_code | lat    | lng      |
    | 1            | Academy        | 780 8th Ave     | 3rd floor | New York      | NY       | 10036       | 40.753 | -73.999  |
    | 2            | Academy        | 1166 Howard St. |           | San Francisco | CA       | 94103       | 37.805 | -122.410 |

  @geocode_user
  Scenario: Registered user
    Given geocoding users is enabled
      And the request ip address is "173.247.202.228"
     When I go to the academies page
     Then I should see "Ralph Gracie" listed in the nearest academies
