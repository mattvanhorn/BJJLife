@http://www.pivotaltracker.com/story/new
Feature: Product categories
  In order to quickly navigate to the products I'm interested in
  As a user
  I want products to be categorized

  Scenario: Products page
    Given the following categories:
    | id | name     |
    | 1  | Classes  |
    | 2  | Seminars |
    And the following products:
    | id | name | price | photo     | category_id |
    | 1  | foo  | 1000  | sloth.jpg | 1           |
    | 2  | bar  | 1500  | sloth.jpg | 2           |
    | 3  | baz  | 2000  | sloth.jpg | 3           |
    | 4  | qux  | 2500  | sloth.jpg | 4           |
    When I go to the products page
    Then I should see "Seminars" within the category selector
    And I should see "Classes" within the category selector
    And I should see 4 product slides in the carousel
