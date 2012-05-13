Then /^I should see the tracking code$/ do
  page.body.should match /#{ENV['GA_TRACKING_ID']}/
end

Then /^I should((?: not)?) see a conversion$/ do |negate|
  should_or_not = negate.present? ? :should_not : :should
  page.body.send(should_or_not, match(/'_trackEvent', "Event", "signup"/))
end