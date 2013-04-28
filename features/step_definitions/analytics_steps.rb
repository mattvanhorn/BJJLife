When /^I (?:am on|go to) the home page for option (a|b)$/ do |choice|
  Site.home_page.load(image: choice)
end

Then /^I should see the tracking code$/ do
  page.body.should match /#{ENV['GA_TRACKING_ID']}/
end

Then /^I should((?: not)?) see a conversion$/ do |negate|
  should_or_not = negate.present? ? :should_not : :should
  page.body.send(should_or_not, match(/'_trackEvent', "Event", "subscribe"/))
end

Then /I should see the (original|new) image/ do |version|
  filename = "#{version == 'new' ? 'bjjmats.jpg' : 'bjjmatch.jpg'}"
  Site.home_page.banner_img[:src].should == "/assets/#{filename}"
end

Then /I should see all the subscribers/ do
  Subscription.all.each do |expected|
    Site.subscriptions_admin_page.subscribers.detect{|s|s.has_text? expected.email}.should be_present
    puts "found #{expected.email}"
  end
end
