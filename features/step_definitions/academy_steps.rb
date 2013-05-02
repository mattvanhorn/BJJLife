# encoding: utf-8
When /(?:I|a user) adds? an academy(?: in the US)?$/ do
  @current_page.add_us_academy
end

When /(?:I|a user) adds? an academy outside the US/ do
  @current_page.add_brazilian_academy
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

When "I follow the academy guide link" do
  Site.home_page.academy_guide_link.click
end

Then "all the academies should be listed under the right state" do
  page = Site.academies_page
  expected = Academy.published.all

  page.us_states.size.should == expected.map(&:us_state).uniq.size

  expected.each do |academy|
    page.state_section(academy.us_state).should have_text(academy.name)
  end
end

Then /^I (should|should not) see (the|\d+) academ(?:y|ies) list(?:ed|ings?)$/ do |should_or_not, num_or_the|
  if num_or_the == 'the'
    expected = @current_page.find_by_name(:academies, :name, Academy.last.name)
    expected.send should_or_not, be_present
  else
    @current_page.academies.size.should == num_or_the.to_i
  end
end
