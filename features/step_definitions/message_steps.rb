Then /I (should|should not) see (?:a|an|the) ([\w ]+) message$/ do |should_or_not, msg_name|
  matcher_type = (should_or_not == :should) ? "have_" : "have_no_"
  matcher = matcher_type + msg_name.gsub(/[^\w]+/, '_')
  @current_page.should send(matcher)
end

Then "I should see the name of the site" do
  @current_page.should have_site_name
end
