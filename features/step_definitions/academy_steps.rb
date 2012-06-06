Then /^I should see "(.*?)" under "(.*?)"$/ do |text, page_section|
  within(selector_for(page_section)) do
    step("I should see \"#{text}\"")
  end
end

When /^I fill out the form with:$/ do |table|
  table.rows_hash.each do |name, val|
    fill_in name, :with => val
  end
end

When /(?:I|a user) adds? an academy/ do
  { I18n.t('activerecord.attributes.academy.name')         => "Vitor Shaolin's Brazilian Jiu Jitsu",
    I18n.t('activerecord.attributes.academy.instructor')   => "Vitor Shaolin",
    I18n.t('activerecord.attributes.academy.street')       => "780 8th Ave",
    I18n.t('activerecord.attributes.academy.unit')         => "3rd floor",
    I18n.t('activerecord.attributes.academy.city')         => "New York",
    I18n.t('activerecord.attributes.academy.us_state')     => "NY",
    I18n.t('activerecord.attributes.academy.postal_code')  => "10036",
    I18n.t('activerecord.attributes.academy.email')        => "tkd@4blackbelt.com",
    I18n.t('activerecord.attributes.academy.phone_number') => "(212) 957-4045",
    I18n.t('activerecord.attributes.academy.website')      => "http://bjjnewyorkcity.com/"}.each do |field, value|
    fill_in field, :with => value
  end
  click_on("Create Academy")
end

Then /^I should see (\d+) (academy listing)$/ do |num, item|
  page.should have_selector(selector_for(item), :count => num.to_i)
end

When "the academy listing is published" do
  step('I perform HTTP authentication as "admin/password"')
  visit path_to("the admin academies page")
  click_on("Publish")
end