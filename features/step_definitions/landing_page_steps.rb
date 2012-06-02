Then "I should see the name of the site" do
  page.should have_content(I18n.t('site_name'))
end

Then "I should see an explanatory message" do
  as_expected = strip_tags(I18n.t('landing_page.explanation_html'))
  page.should have_content(as_expected)
end

Then "I should see a thank you message" do
  as_expected = strip_tags(I18n.t('subscriptions.thanks.message_html'))
  page.should have_content(as_expected)
end

Then /^I should see the "([^"]*)" form$/ do |form_name|
  page.should have_selector(selector_for("the #{form_name} form"))
end

When /^I sign up for the list as "([^"]*)"$/ do |email|
  fill_in I18n.t('simple_form.labels.defaults.email'), :with => email
  within selector_for("the signup form") do
    click_on I18n.t('helpers.submit.subscription.create')
  end
end

Given /^the email "([^"]*)" is on the announcement list$/ do |email|
  Subscription.find_or_create_by_email(email)
end


