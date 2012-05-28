Transform /^(should|should not)$/ do |should_or_not|
  should_or_not.gsub(' ', '_').to_sym
end

Given /^the site is not launched$/ do
  #NO-OP
end

When /^(?:they|I) fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:they|I) click on "([^"]*)"$/ do |link_or_button|
  click_on(link_or_button)
end

When "I accept the confirmation dialog" do
  unless page.driver.browser.is_a? Capybara::RackTest::Browser
    page.driver.browser.switch_to.alert.accept
  end
end

When /^(.*) within ([^:"]+)$/ do |scoped_step, scope|
  within(selector_for(scope)) do
    step(scoped_step)
  end
end

When /^(.*) within ([^:"]+):$/ do |scoped_step, scope, table_or_string|
  within(selector_for(scope)) do
    step("#{scoped_step}:", table_or_string)
  end
end

Then /^(?:they|I) (should|should not) see "([^"]*)"$/ do |should_or_not, content|
  page.send should_or_not, have_content(content)
end

Then /^show me the page$/ do
  save_and_open_page
end

Then /^I should see a blog entry titled "(.*?)" and linked to "(.*?)"$/ do |title, url|
  page.should have_selector("#{selector_for("a blog entry")} a[href='#{url}']", :text => title)
end