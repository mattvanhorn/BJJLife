Then /^I should see "(.*?)" under "(.*?)"$/ do |text, page_section|
  within(selector_for(page_section)) do
    step("I should see \"#{text}\"")
  end
end