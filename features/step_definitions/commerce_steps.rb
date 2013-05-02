require 'active_support/core_ext/string'
include ExhibitCurrencyHelper

Given /a product with a market and category/ do
  @product  = Fabricate(:product_with_category_and_market).reload
  @market   = @product.market
  @category = @product.category
end

Given /a signed-in user (?:in|with) (that|a different|no) market/ do |mkt_opt|
  market = case mkt_opt
  when 'that' then @product.market
  when 'a different' then Fabricate(:different_market)
  when 'no' then nil
  end
  @user = Fabricate(:identity_with_user_in_market, sign_in_count: 2, market: market).user.reload
  Site.sign_in_page.go.sign_in_with(@user.identity_email, 'password')
end

When /I add a (product|category)/ do |model|
  page_name = "new_#{model}_admin_page"
  method_name = "add_a_#{model}"
  Site.send(page_name).send(method_name)
end

When /I delete the category named "(.*?)"/ do |title|
  Site.categories_admin_page.delete_category(title)
end

When /^I update product (\d+) with the category "(.*?)"$/ do |product_id, category|
  page = Site.edit_product_admin_page
  page.load(product_id: product_id)
  page.update_product_category(category)
end

When /^I go to the product page for that product$/ do
  Site.product_page.load(product_id: @product.id)
end

When /I buy that product/ do
  Site.product_page.go(product_id: @product.id).buy_btn.click
end

When /I sign in as that user/ do
  Site.new_order_page.sign_in_link.click
  Site.sign_in_page.sign_in_with(@user.identity_email, 'password')
end

When /I try to register with an email that is already used/ do
  page = Site.new_order_page
  page.email_field.set Identity.last.email
  page.password_field.set "seekrit"
  page.password_confirmation_field.set "seekrit"
end

When /I enter my registration info/ do
  page = Site.new_order_page
  page.email_field.set "alice@example.com"
  page.password_field.set "seekrit"
  page.password_confirmation_field.set "seekrit"
end

When /I enter (bad|my) credit card info/ do |bad_or_good|
  page = Site.new_order_page
  page.first_name_field.set "Alice"
  page.last_name_field.set "Kramden"
  page.card_number_field.set (bad_or_good == 'bad' ? 'foobar' : "4242424242424242")
  page.card_cvv_field.set "123"
  page.card_month_select.select "1 - Jan"
  page.card_year_select.select "2020"
end

When /I enter my address info/ do
  page = Site.new_order_page
  page.street_field.set "1313 Mockingbird Lane"
  page.unit_field.set "42"
  page.city_field.set "Gotham"
  page.us_state_field.set "NY"
  page.postal_code_field.set "12345"
end

Then /^I should see (\d+) ([\w]+) slides in the carousel$/ do |num, model|
  page.should have_selector("#carousel .#{model}", :count => num.to_i)
end

Then /^(?:I|they) (should|should not) see that product$/ do |should_or_not|
  Site.products_page.send(should_or_not, have_product(@product))
end

%w(category product).each do |model|
  collection = model.pluralize
  klass = model.classify.constantize
  Then "I should see the #{model} I added" do
    Site.send("#{collection}_admin_page").send(collection).detect{|x|x.has_text? klass.last.name}.should be_present
  end

  Then "I should see all the #{collection}" do
    klass.all.each do |record|
      @current_page.send(collection).detect{|x|x.has_text? record.name}.should be_present
    end
  end
end

Then /I should see basic info for all the products/ do
  page = Site.products_page
  Product.all.each do |prod|
    page.products.detect{|p|(p.has_text? prod.name) &&( p.has_text? dollarize prod.price)}.should be_present
    page.detail_links.detect{|p|p[:href] == product_path(prod)}.should be_present
    page.buy_links.detect{|p|p[:href] == new_product_order_path(prod)}.should be_present
  end
end

Then /I should see the product details/ do
  page = Site.product_page
  page.should be_displayed
  page.product_name.should have_text(@product.name)
  page.product_price.should have_text(dollarize @product.price)
end

Then /I should have an order confirmation/ do
  page = Site.order_confirmation_page
  page.wait_for_confirmation
  page.should be_displayed
  page.name.text.should =~ /^#{@product.name}/
  page.quantity.text.should == '1'
  page.price.text.should == dollarize(@product.price)
  page.total.text.should == "Total: #{dollarize(@product.price)}"
end


