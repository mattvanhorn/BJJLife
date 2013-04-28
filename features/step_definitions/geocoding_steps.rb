When "geocoding users is enabled" do
  Rails.application.config.stub(:locate_users => true)
end

When /^the request ip address is "([^\"]*)"$/ do |ip_address|
  ENV['RAILS_TEST_IP_ADDRESS'] = ip_address
end

Then(/^I should see "(.*?)" listed in the nearest academies$/) do |name|
  Site.academies_page.nearest.should have_academy(name)
end
