Transform /^(should|should not)$/ do |should_or_not|
  should_or_not.gsub(' ', '_').to_sym
end

Then /^(?:they|I) (should|should not) see "([^"]*)"$/ do |should_or_not, content|
  page.send should_or_not, have_content(content)
end

Then /^show me the page$/ do
  save_and_open_page
end

Then /^show me the url$/ do
  puts current_url
end

Then /"(.*)" should appear before "(.*)"/ do |first_example, second_example|
  page.body.should =~ /#{first_example}.*#{second_example}/m
end

Then(/^I (should|should not) see "(.*?)" on the (.* page)$/) do |should_or_not, text, page_name|
  page = get_page(page_name)
  page.load unless page.displayed?
  page.send should_or_not, have_text(text)
end

Then "I should see the signup form" do
  @current_page.sign_up_form.should be_present
end
