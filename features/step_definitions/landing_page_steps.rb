Then /^I should see the "([^"]*)" form$/ do |form_name|
  page.should have_selector(selector_for("the #{form_name} form"))
end

When /^I sign up for the list as "([^"]*)"$/ do |email|
  Site.home_page.do_subscribe(email)
end

Given /^the email "([^"]*)" is on the announcement list$/ do |email|
  Subscription.find_or_create_by_email(email)
end


