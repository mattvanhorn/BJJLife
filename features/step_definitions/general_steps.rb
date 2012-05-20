Given /^the site is not launched$/ do
  #NO-OP
end

When /^(?:they|I) fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:they|I) click on "([^"]*)"$/ do |link_or_button|
  click_on(link_or_button)
end

Then /^show me the page$/ do
  save_and_open_page
end