# encoding: utf-8
Then "all the academies should be listed under the right state" do
  page = Site.academies_page
  expected_academies = Academy.published.all

  page.us_states.size.should == expected_academies.map(&:us_state).uniq.size

  expected_academies.each do |academy|
    page.state_section(academy.us_state).should have_text(academy.name)
  end
end

When /(?:I|a user) adds? an academy(?: in the US)?$/ do
  @current_page.add_us_academy
end

When /(?:I|a user) adds? an academy outside the US/ do
  @current_page.add_brazilian_academy
end

Then(/^I (should|should not) see the academy listed$/) do |should_or_not|
  page = Site.academies_page
  expected_academy = Academy.last
  academy = page.academies.detect{|a|a.name.text == expected_academy.name}
  academy.send should_or_not, be_present
end

Then /^I should see (\d+) (academy listing)$/ do |num, item|
  page.should have_selector(selector_for(item), :count => num.to_i)
end

When 'I publish the academy listing' do
  Site.academies_admin_page.publish_links.first.click
end

When /the academy listing is published/ do
  step('I perform HTTP authentication as "admin/password"')
  Site.academies_admin_page.load
  step('I publish the academy listing')
end

When /I search for academies near (.*)/ do |zip_or_loc|
  page = Site.academies_page
  page.search_field.set zip_or_loc
  page.search_btn.click
end

