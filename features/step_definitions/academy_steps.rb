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
  {"Name"       => "Vitor Shaolin's Brazilian Jiu Jitsu",
  "Instructor" => "Vitor Shaolin",
  "Street"     => "780 8th Ave",
  "Unit"       => "3rd floor",
  "City"       => "New York",
  "State"      => "NY",
  "ZIP Code"   => "10036",
  "Email"      => "tkd@4blackbelt.com",
  "Phone"      => "(212) 957-4045",
  "Website"    => "http://bjjnewyorkcity.com/"}.each do |field, value|
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