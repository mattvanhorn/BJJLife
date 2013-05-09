Given /I am signed in as a user(?: with (\d+) previous visits?)?/ do |num_visits|
  opts = {password: 'password', sign_in_count: num_visits.try(:to_i)}
  identity = Fabricate(:identity_with_user, opts).reload
  Site.sign_in_page.go.sign_in_with(identity.email, 'password')
end

# NOTE: for when you need a returning user, but not necessarily signed in
Given /a returning user/ do
  @identity = Fabricate(:identity_with_user, sign_in_count: 2).reload
  @user = @identity.user
end

Given /I am not signed in|I sign out/ do
  visit sign_out_path
end

Then /I (should|should not) see a personalized greeting on the home page/ do |should_or_not|
  page = Site.home_page.go
  page.send should_or_not, have_text("Hi #{@me.username},")
end

def humanize(txt)
  txt.to_s.gsub(/[^A-Za-z0-9]+/,' ')
end
%w(missing_email missing_password missing_email_and_password invalid_credentials).each do |msg|
  Then "I should see the #{humanize(msg)} message on the sign in page" do
    page = Site.sign_in_page
    page.should be_displayed
    page.should send("have_#{msg}_msg")
  end
end

Then /^I (should|should not) be subscribed$/ do |should_or_not|
  Subscription.find_by_email(Identity.last.email).send should_or_not, be_present
end
