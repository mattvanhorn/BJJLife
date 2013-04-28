When /^I update my profile$/ do
  profile = Site.edit_account_page
  profile.should be_displayed
  profile.nickname_field.set "Alice K"
  profile.teacher_field.set "Vitor 'Shaolin' Ribeiro"
  profile.rank_field.set "Blue belt"
  profile.update_btn.click
end

When /^I navigate to "(.*?)"$/ do |link_text|
  page = Site.home_page
  page.load
  element = link_text.gsub(/\s+/,'_').downcase
  page.navigation.send(element).click
end

Then /^I should see my profile details$/ do
  expected_profile = User.last
  profile = Site.account_page
  profile.nickname.text.should  =~ %r(#{expected_profile.username})
  profile.teacher.text.should   =~ %r(#{expected_profile.teacher})
  profile.rank.text.should      =~ %r(#{expected_profile.rank})
end

Given /^I am signed in as a user$/ do
  identity = Fabricate(:identity_with_user, password: 'password')
  Site.sign_in_page.go.sign_in_with(identity.email, 'password')
end

Given /I am signed in as a user with (\d+) previous visits?/ do |num_visits|
  identity = Fabricate(:identity_with_user, sign_in_count: num_visits.to_i, password: 'password')
  Site.sign_in_page.go.sign_in_with(identity.email, 'password')
end

Given /I am not signed in|I sign out/ do
  visit sign_out_path
end

When /I sign in successfully/ do
  identity = Fabricate(:identity_with_user, sign_in_count: 2, password: 'password')
  Site.sign_in_page.go.sign_in_with(identity.email, 'password')
end

When /I sign in without (a password|an email|any credentials)/ do |missing|
  user = Fabricate(:identity_with_user, sign_in_count: 2)
  page = Site.sign_in_page
  if missing == 'any credentials'
    page.go.sign_in_with('', '')
  else
    email = 'alice@example.com' unless missing == 'an email'
    password = 'password' unless missing == 'a password'
    page.go.sign_in_with(email, password)
  end
end

When /I sign in with bad credentials/ do
  user = Fabricate(:identity_with_user, sign_in_count: 2)
  Site.sign_in_page.go.sign_in_with('wrong@example.com', 'wrong_password')
end

Then /I (should|should not) see a personalized greeting on the home page/ do |should_or_not|
  page = Site.home_page.go
  page.send should_or_not, have_text("Hi #{User.last.username},")
end

Then(/^I should see the missing (password|email|email and password) message on the sign in page$/) do |missing|
  page = Site.sign_in_page
  page.should be_displayed
  page.should have_text(I18n.t("omniauth.#{missing.gsub(/\s+/,'_')}_missing"))
end

Then(/^I should see the invalid credentials message on the sign in page$/) do
  page = Site.sign_in_page
  page.should be_displayed
  page.should have_text(I18n.t("omniauth.invalid_credentials"))
end

When /^I sign up without opting in to a subscription$/ do
  Site.sign_up_page.sign_up_and_opt_out
end

When /^I sign up and opt in to a subscription$/ do
  Site.sign_up_page.sign_up_and_opt_in
end

Then /^I (should|should not) be subscribed$/ do |should_or_not|
  Subscription.find_by_email(Identity.last.email).send should_or_not, be_present
end
