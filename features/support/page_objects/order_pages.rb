class NewOrderPage < SitePrism::Page
  set_url "/products{/product_id}/orders/new"
  set_url_matcher %r(/products/\d+/orders/new)

  element :sign_in_link, 'a[href="/sign_in"]'

  element :email_field,                 "input[name='order[email]']"
  element :password_field,              "input[name='identity[password]']"
  element :password_confirmation_field, "input[name='identity[password_confirmation]']"

  element :first_name_field, "input[name='order[bill_first_name]']"
  element :last_name_field, "input[name='order[bill_last_name]']"
  element :card_number_field, "input#card_number"
  element :card_cvv_field,    "input#card_code"
  element :card_month_select,  "select#cc_exp_month"
  element :card_year_select,   "select#cc_exp_year"

  element :street_field,      "input[name='order[bill_street]']"
  element :unit_field,        "input[name='order[bill_street]']"
  element :city_field,        "input[name='order[bill_street]']"
  element :us_state_field,    "input[name='order[bill_us_state]']"
  element :postal_code_field, "input[name='order[bill_postal_code]']"

  element :place_order_btn, "input[name='commit']"
end

class OrderConfirmationPage < SitePrism::Page
  set_url "/orders{/order_id}"
  set_url_matcher %r(/orders/\d+)

  element :confirmation, ".confirmation"
  element :name, ".confirmation .name"
  element :quantity, ".confirmation .quantity"
  element :price, ".confirmation .price"
  element :total, ".confirmation .total"
end

class FailedCheckoutPage < NewOrderPage
  set_url nil # should not be able to load this directly.
  set_url_matcher %r(/products/\d+/orders)
  # /products/32/orders/new
end
