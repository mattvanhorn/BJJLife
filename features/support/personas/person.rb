require 'virtus'

class Person
  include Virtus

  attribute :username,  String
  attribute :email,     String
  attribute :password,  String

  def do_sign_up(wants_subscription = true)
    visit :sign_up_page
    page.email_field.set email
    page.password_field.set password
    page.password_confirmation_field.set password
    page.opt_in_box.set wants_subscription
    page.sign_up_btn.click
  end

  def sign_up_and_opt_out
    do_sign_up(false)
  end
  alias :sign_up :sign_up_and_opt_out

  def sign_up_and_opt_in
    do_sign_up
  end

  def sign_in(kind=:successfully)
    email, password = *credentials(kind)
    visit :sign_in_page
    page.email_field.set email
    page.password_field.set password
    page.sign_in_btn.click
  end

  def visit(site_page)
    Site.send(site_page).go
  end

  private

  def page
    Site.current_page
  end

  def credentials(kind=nil)
    case kind
      when :without_a_password then [email, '']
      when :without_an_email then ['', password]
      when :without_any_credentials then ['','']
      when :with_bad_credentials then ['wrong'+email, 'wrong'+password]
      else [email, password]
    end
  end

end
