@http://www.pivotaltracker.com/story/31487351
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
    | 3  | baz  | 2000  | sloth.jpg | 1           |
    | 4  | qux  | 2500  | sloth.jpg | 2           |
    When I go to the products page
    Then I should see all the categories
     And I should see all the products
