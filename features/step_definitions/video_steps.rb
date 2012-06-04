Then /^I should see a video item for "(.*?)" linked to "(.*?)"$/ do |name, url|
  page.should have_selector("li.video a[href='#{url}']", :text => name)
end

When /(?:I|a user) adds? a video/ do
  {"Name" => "Vitor Shaolin's Brazilian Jiu Jitsu",
  "URL" => "http://www.example.com"}.each do |field, value|
    fill_in field, :with => value
  end
  click_on("Create Video")
end