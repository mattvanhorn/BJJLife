@http://www.pivotaltracker.com/story/show/29438515
Feature: Join announcement list
  In order to find out when the site launches
  As a user
  I want to sign up for announcements

  Scenario: Reading about the site
    When I am on the home page
    Then I should see the name of the site
     And I should see the explanation message

  Scenario: Signing up
    Given I am on the home page
     When I sign up for the list as "alice@example.com"
     Then I should be on the subscription thank you page
      And I should see the name of the site
      And I should see the thank you message

  Scenario: Blank email
    Given I am on the home page
     When I sign up for the list as ""
     Then I should see "Email can't be blank"
      And I should see the "signup" form

  Scenario: Invalid email
    Given I am on the home page
     When I sign up for the list as "not_an_email"
     Then I should see "Email is not valid"
      And I should see the "signup" form

  Scenario: Duplicate email
    Given I am on the home page
      And the email "alice@example.com" is on the announcement list
     When I sign up for the list as "alice@example.com"
     Then I should see "Email has already been taken"
      And I should see the "signup" form
