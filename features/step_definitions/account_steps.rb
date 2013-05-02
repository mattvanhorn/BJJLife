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

When /^I update my profile$/ do
  Site.edit_account_page.update_profile
end

{ 'successfully'            => ['alice@example.com','password'],
  'without a password'      => ['alice@example.com',''],
  'without an email'        => ['','password'],
  'without any credentials' => ['',''],
  'with bad credentials'    => ['wrong@example.com','wrong_password']
}.each_pair do |that_way, credentials|
  When "I sign in #{that_way}" do
    user = Fabricate(:identity_with_user, sign_in_count: 2, password: 'password', email: 'alice@example.com')
    Site.sign_in_page.go.sign_in_with(*credentials)
  end
end

When /^I sign up (without opting|and opt) in to a subscription$/ do |action|
  action = (action == 'and opt') ? 'in' : 'out'
  Site.sign_up_page.send("sign_up_and_opt_#{action}")
end

When /^I sign up$/ do
  Site.sign_up_page.go.sign_up
end

Then /^I should see my profile details$/ do
  expected = User.last
  %w(username teacher rank).each do |attr|
    Site.account_page.send(attr).should have_text(expected.send(attr))
  end
end

Then /I (should|should not) see a personalized greeting on the home page/ do |should_or_not|
  page = Site.home_page.go
  page.send should_or_not, have_text("Hi #{User.last.username},")
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
