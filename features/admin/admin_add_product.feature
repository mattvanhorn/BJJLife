@http://www.pivotaltracker.com/story/show/31395117 @admin
Feature: Admin Add Product
  In order to sell stuff
  As an admin
  I want to add a product

  Background:
    Given I perform HTTP authentication as "admin/password"

  Scenario: Getting to the admin page
    Given I am on the admin products page
    When I click on "Add Product"
    Then I should be on the new admin product page

  @vcr
  Scenario:
    Given there are no products
    And I am on the new admin product page
    When I fill in "Name" with "Loro Private"
    And I fill in "Price" with "12000"
    And I attach the image "sloth.jpg" as "Photo"
    And I click on "Create Product"
    Then I should be on the admin products page
    And I should see "Loro Private"

