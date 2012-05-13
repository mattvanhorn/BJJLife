Then /^I should see the tracking code$/ do
  page.body.should match /#{ENV['GA_TRACKING_ID']}/
end

Then /^I should((?: not)?) see a conversion$/ do |negate|
  should_or_not = negate.present? ? :should_not : :should
  page.body.send(should_or_not, match(/'_trackEvent', "Event", "signup"/))
end

Then /I should see the (original|new) landing page text/ do |version|
  key = "landing_page.#{version == 'new' ? 'new_' : ''}explanation_html"
  as_expected = strip_tags(I18n.t(key))
  page.should have_content(as_expected)
end
