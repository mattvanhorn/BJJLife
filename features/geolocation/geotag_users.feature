@http://www.pivotaltracker.com/story/show/48366221
Feature: Geotag users
  In order to see products near me
  As a user
  I want the site to guess my location

  Background:
    Given the following markets:
    | id | name          |
    | 1  | New York      |
    | 2  | San Francisco |
    Given the following locations:
    | postal_code | us_state | city          | locatable_id | locatable_type | lat       | lng         |
    | 10001       | NY       | New York      | 1            | Market         | 40.753685 | -73.999164  |
    | 94133       | CA       | San Francisco | 2            | Market         | 37.805989 | -122.409915 |

  @geocode_user
  Scenario: First Visit
    Given geocoding users is enabled
      And the request ip address is "173.247.202.228"
      And I am not signed in
     When I visit the products page
     Then I should see "Showing Products in San Francisco"
