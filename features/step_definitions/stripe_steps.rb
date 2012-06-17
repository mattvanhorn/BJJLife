When /^I place the order$/ do
  click_on "Place Order"
  sleep(2) # nasty, but makes the javascript happy.
end