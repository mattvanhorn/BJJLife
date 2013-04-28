Then /^there (should|should not) be a subscription for "(.*?)"$/ do |should_or_not, email|
  Subscription.find_by_email(email).send should_or_not, be_present
end

Given /^that identity is signed in$/ do
  step('I am signed in as "'+@identity.email+'" with a password of "'+@identity.password+'"')
end

Given /^I am signed in as "(.*?)" with a password of "(.*?)"$/ do |email, password|
  step("I visit the sign in page")
  step('I fill in "Email" with "' + email + '"')
  step('I fill in "Password" with "' + password + '"')
  step('I click on "Sign In" within the form')
end

When /^I register as "(.*?)" using the password "(.*?)"$/ do |email, password|
  step("I visit the sign up page")
  step('I fill in "Email" with "' + email + '"')
  step('I fill in "Password" with "' + password + '"')
  step('I fill in "Confirm password" with "' + password + '"')
  step('I click on "Sign Up" within the form')
end

Given /^that user's market is unknown$/ do
  @identity.user.market = nil
end

Given /^a signed-in user$/ do
  step 'a signed-in user with the username "alice" and an identity of "alice@example.com" and "password"'
end

Given /^a signed-in user with the username "(.*?)" and an identity of "(.*?)" and "(.*?)"$/ do |username, email, password|
  steps %~
    Given the following user:
      | username      | #{username} |
      And the following identity:
      | email    | #{username} |
      | password | #{password} |
      And that identity belongs to that user
      And that identity is signed in
  ~
end

Given /a returning user/ do
  @identity = Fabricate(:identity_with_user, :sign_in_count => 2).reload
  @user = @identity.user
end




