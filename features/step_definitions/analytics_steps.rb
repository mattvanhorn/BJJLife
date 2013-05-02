Then /^I should see the tracking code$/ do
  page.body.should match /#{ENV['GA_TRACKING_ID']}/
end

Then /^I (should|should not) see a conversion$/ do |should_or_not|
  page.body.send should_or_not, match(/'_trackEvent', "Event", "subscribe"/)
end

Then /I should see the (original|new) image/ do |version|
  filename = (version == 'new') ? 'bjjmats.jpg' : 'bjjmatch.jpg'
  Site.home_page.banner_img[:src].should == "/assets/#{filename}"
end

Then /I should see all the subscribers/ do
  Subscription.all.each do |expected|
    @current_page.subscribers.detect{|s|s.has_text? expected.email}.should be_present
  end
end
