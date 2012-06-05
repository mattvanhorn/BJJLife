Given "there are no registered users" do
  Identity.destroy_all
  User.destroy_all
end

Given "there are no subscriptions" do
  Subscription.destroy_all
end

Then /^there (should|should not) be a subscription for "(.*?)"$/ do |should_or_not, email|
  Subscription.find_by_email(email).send should_or_not, be_present
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
