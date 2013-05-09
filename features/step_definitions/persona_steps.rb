Given(/^a user: (.*)$/) do |name|
  Persona.called(name).create
end

Given /^the users: (.*)$/ do |names|
  names = names.split(/\s+|\W+/).reject{|name|name=='and'}
  names.each do |name|
    step "a user: #{name}"
  end
end

Given(/^(\w+) signs in$/) do |name|
  Persona.called(name).sign_in
end

Given(/^I am playing the role: (\w+)$/) do |name|
  @me = Persona.called(name)
end

Given(/^I am signed in as (\w+)$/) do |name|
  # step "a user: #{name}"
  step "I am playing the role: #{name}"
  step "#{name} signs in"
end

When /I sign in (successfully|(?:with(?:out)?)(?: a password| an email| any credentials| bad credentials))/ do |how|
  that_way = how.gsub(/\s+/,'_').to_sym
  @me.sign_in(that_way)
end

When /^I sign in$/ do
  @me.sign_in
end

When /^I sign up$/ do
  @me.sign_up
end

When /^I sign up (without opting|and opt) in to a subscription$/ do |action|
  if (action == 'and opt')
    @me.sign_up_and_opt_in
  else
   @me.sign_up_and_opt_out
 end
end

When /^I update my profile$/ do
  @me.update_profile
end

Then(/^I should have a user named "(.*?)"$/) do |arg1|
  puts @user.inspect
end

Then /^I should see my profile details$/ do
  %w(username teacher rank).each do |attr|
    Site.current_page.send(attr).should have_text(@me.send(attr))
  end
end
