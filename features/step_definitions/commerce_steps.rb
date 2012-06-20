Then /^I should see (\d+) ([\w]+) slides in the carousel$/ do |num, model|
  page.should have_selector("#carousel .#{model}", :count => num.to_i)
end