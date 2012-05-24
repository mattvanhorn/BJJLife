When /^(?:they|I) should be on (.+)$/ do |page_name|
  location = URI.parse(current_url).path
  expected = path_to(page_name)
  if expected.respond_to?(:match)
    expected.should match(location)
  else
    location.should == expected
  end
end

When /^(?:they|I) (?:visit|am on|are on|go to) (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I perform HTTP authentication as "([^\"]*)\/([^\"]*)"$/ do |name, password|
  if page.driver.respond_to?(:basic_auth)
    page.driver.basic_auth(name, password)
  elsif page.driver.respond_to?(:basic_authorize)
    page.driver.basic_authorize(name, password)
  elsif page.driver.respond_to?(:browser) && page.driver.browser.respond_to?(:basic_authorize)
    page.driver.browser.basic_authorize(name, password)
  else
    raise "I don't know how to log in!"
  end
end

When /^I follow (the .+ link)$/ do |link|
  click_on(selector_for(link))
end