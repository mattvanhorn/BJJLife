When /^(?:they|I) (?:visit|am on|are on|go to) (?:the|my) (.* page)$/ do |page_name|
  get_page(page_name).load
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

When /^I navigate to "(.*?)"$/ do |link_text|
  element = link_text.gsub(/\s+/,'_').downcase
  Site.navigation.send(element).click
end

When "I click on the site logo" do
  Site.home_page.site_logo.click
end

When /^I (?:am on|go to) the home page for option (a|b)$/ do |choice|
  Site.home_page.load(image: choice)
end

Then /^I should be on (?:the|my) (.* page)$/ do |page_name|
  get_page(page_name).should be_displayed
end

Then(/^I should be on the post page for the first post$/) do
  page = Site.post_page
  page.current_url.should include "/posts/#{Blog.first.entries.first.id}"
end
