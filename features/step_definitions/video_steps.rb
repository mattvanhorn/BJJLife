Then /^I should see a video item for "(.*?)" linked to "(.*?)"$/ do |name, url|
  page.should have_selector("li.video a[href='#{url}']", :text => name)
end