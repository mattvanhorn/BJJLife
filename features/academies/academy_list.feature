@http://www.pivotaltracker.com/story/show/30111079 @academies
Feature: Academy List
  In order to find a BJJ academy
  As a prospective student
  I want to see a list of academies sorted by state

  Scenario: Getting to the list
  Given I am on the home page
  When I follow the academy guide link
  Then I should be on the academies page

  Scenario: Viewing the list
  Given the following academies:
  | id | name                                | email              | phone_number   | website                      |
  | 1  | Vitor Shaolin's Brazilian Jiu Jitsu | tkd@4blackbelt.com | (212) 957-4045 | http://bjjnewyorkcity.com/   |
  | 2  | Ralph Gracie SF                     |                    | (415) 552-4777 | http://www.ralphgraciesf.com |
  And the following academy locations:
  | locatable_id | locatable_type | street          | unit      | city          | us_state | postal_code | lat    | lng      |
  | 1            | Academy        | 780 8th Ave     | 3rd floor | New York      | NY       | 10036       | 40.753 | -73.999  |
  | 2            | Academy        | 1166 Howard St. |           | San Francisco | CA       | 94103       | 37.805 | -122.410 |

  When I am on the academies page
  Then I should see "Vitor Shaolin's Brazilian Jiu Jitsu" under "NY"
   And I should see "Ralph Gracie SF" under "CA"
