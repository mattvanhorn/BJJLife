Given "there are no registered users" do
  Identity.destroy_all
  User.destroy_all
end

Given "there are no subscriptions" do
  Subscription.destroy_all
end

Then /^there (should|should not) be a subscription for "(.*?)"$/ do |should_or_not, email|
  Subscription.find_by_email(email).send should_or_not, be_present
end

