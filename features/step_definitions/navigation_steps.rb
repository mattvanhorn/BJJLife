Given /^I am on (.*)$/ do |page_name|
  visit path_to(page_name)
end