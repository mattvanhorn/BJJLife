Transform /^(should|should not)$/ do |should_or_not|
  should_or_not.gsub(' ', '_').to_sym
end

Given /^the site is not launched$/ do
  #NO-OP
end

Then "check product count" do
  Product.count.should > 0
end

Given /^there are no ([\w ]+)$/ do |model_name|
  klasses = case model_name
  when 'registered users'
    [User, Identity]
  else
    model_name.split(',').map{ |m| m.strip.gsub(/\s+/,'_').singularize.classify.constantize }
  end
  klasses.collect{ |model| model.destroy_all }
end

When /^I enter the following information into the form:$/ do |table|
  table.rows_hash.each do |name, val|
    if name.starts_with? 'cc_'
      select val, :from => name
    else
      fill_in name, :with => val
    end
  end
end

When /^(?:they|I) fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^I fill in the (.*) field with "(.*?)"$/ do |name, value|
  fill_in(I18n.t(message_for(name)), :with => value)
end

When /^(?:they|I) click on "([^"]*)"$/ do |link_or_button|
  click_on(link_or_button)
end

When /^I check "([^"]*)"$/ do |checkbox|
  check(checkbox)
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

When /^I attach the image "(.*?)" as "(.*?)"$/ do |filename, locator|
  path = File.join(::Rails.root, "features", "support", "images", filename)
  attach_file(locator, path)
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

Then /^(?:they|I) (should|should not) see (.*) message$/ do |should_or_not, content|
  page.send should_or_not, have_content(strip_tags(I18n.t(message_for(content))))
end

Then /^show me the page$/ do
  save_and_open_page
end

When /^I wait (.*?) seconds$/ do |secs|
  sleep(secs.to_i)
end

Then /^I should see a link to the product detail page for the product named "(.*?)"$/ do |product_name|
  product = Product.find_by_name(product_name)
  page.should have_selector("a[href='#{product_path(product)}']")
end

Then /^I should see a link to buy the product named "(.*?)"$/ do |product_name|
  product = Product.find_by_name(product_name)
  page.should have_selector("a[href='#{new_product_order_path(product)}']")
end

Then /I should see a link to "([^"\s]*)"/ do |href|
  page.should have_selector("a[href='#{href}']")
end

Then /^I should see a blog entry titled "(.*?)" and linked to "(.*?)"$/ do |title, url|
  page.should have_selector("#{selector_for("a blog entry")} a[href='#{url}']", :text => title)
end

Then /"(.*)" should appear before "(.*)"/ do |first_example, second_example|
  page.body.should =~ /#{first_example}.*#{second_example}/m
end

Then "I am not signed in" do
  visit sign_out_path
end
