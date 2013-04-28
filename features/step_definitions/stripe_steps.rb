When /^I place the order$/ do
  Site.new_order_page.place_order_btn.click
  sleep(5) # nasty, but makes the javascript happy.
end
