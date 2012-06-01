Then /^I should see the tracking code$/ do
  page.body.should match /#{ENV['GA_TRACKING_ID']}/
end

Then /^I should((?: not)?) see a conversion$/ do |negate|
  should_or_not = negate.present? ? :should_not : :should
  page.body.send(should_or_not, match(/'_trackEvent', "Event", "subscribe"/))
end

Then /I should see the (original|new) image/ do |version|
  filename = "#{version == 'new' ? 'bjjmats.png' : 'bjjmatch.png'}"
  page.should have_selector("img[src='/assets/#{filename}']")
end
