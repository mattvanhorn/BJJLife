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