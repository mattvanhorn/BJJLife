@http://www.pivotaltracker.com/story/show/31565937
Feature: Category Administration
  In order to categorize products
  As an admin
  I want to add and delete categories, and assign them to products.

  Background:
    Given I perform HTTP authentication as "admin/password"

  Scenario: Adding a category
    When I add a category
    Then I should be on the categories admin page
     And I should see the category I added

  Scenario: Delete a category
    Given the following categories:
        | id   | name                                            |
        | 1001 | Products that belong to the Emperor             |
        | 1002 | Products included in the present classification |
        | 1003 | Products drawn with a very fine camelhair brush |
     Then I should see "Products that belong to the Emperor" on the categories admin page
     When I delete the category named "Products that belong to the Emperor"
     Then I should not see "Products that belong to the Emperor" on the categories admin page

  Scenario: Categorize Products
    Given the following categories:
     | id   | name                                            |
     | 1001 | Products that belong to the Emperor             |
     | 1002 | Products included in the present classification |
     | 1003 | Products drawn with a very fine camelhair brush |
    And the following products:
     | id | name | price | photo     | category_id |
     | 1  | foo  | 1000  | sloth.jpg | 1002        |
     | 2  | bar  | 1500  | sloth.jpg | 1002        |
    Then I should not see "Products that belong to the Emperor" on the products admin page
    When I update product 1 with the category "Products that belong to the Emperor"
    Then I should see "Products that belong to the Emperor" on the products admin page

