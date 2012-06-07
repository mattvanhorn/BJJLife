When /^I place the order$/ do
  # VCR.use_cassette('stripe_api/create_charge/success') do
    click_on "Place Order"
  # end
end