class EditAccountPage < SitePrism::Page
  URL = Rails.application.routes.url_helpers.edit_account_path
  set_url URL
  set_url_matcher %r(#{URL})

  element :nickname_field, "input[name='user[username]']"
  element :teacher_field, "input[name='user[teacher]']"
  element :rank_field, "input[name='user[rank]']"
  element :update_btn, "input[name='commit']"

  def update_profile
    nickname_field.set "Alice K"
    teacher_field.set "Vitor 'Shaolin' Ribeiro"
    rank_field.set "Blue belt"
    update_btn.click
  end
end

class SignUpPage < SitePrism::Page
  URL = Rails.application.routes.url_helpers.sign_up_path
  set_url URL
  set_url_matcher %r(#{URL})

  element :email_field,                 "input[name='email']"
  element :password_field,              "input[name='password']"
  element :password_confirmation_field, "input[name='password_confirmation']"
  element :opt_in_box,                  "input[name='opt_in']"
  element :sign_up_btn,                 "input[name='commit']"

  def sign_up_and_opt_in
    load
    fill_out_form(true)
    sign_up_btn.click
  end

  def sign_up_and_opt_out
    load
    fill_out_form
    sign_up_btn.click
  end
  alias :sign_up :sign_up_and_opt_out

  private

  def fill_out_form(opt_in=false)
    email_field.set "alice@example.com"
    password_field.set "password"
    password_confirmation_field.set "password"
    opt_in_box.set true if opt_in
  end
end

class AccountPage < SitePrism::Page
  URL = Rails.application.routes.url_helpers.account_path
  set_url URL
  set_url_matcher %r(#{URL})

  element :username, "h3.nickname"
  element :teacher, "p.teacher"
  element :rank, "p.rank"
end

class SignInPage < SitePrism::Page
  URL = Rails.application.routes.url_helpers.sign_in_path
  set_url URL
  set_url_matcher %r(#{URL})

  element :email_field, "input[name='auth_key']"
  element :password_field, "input[name='password']"
  element :sign_in_btn, "input[name='commit']"

  set_message_translator { |key| I18n.t(key) }
  message :missing_email_msg, "omniauth.email_missing"
  message :missing_password_msg, "omniauth.password_missing"
  message :missing_email_and_password_msg, "omniauth.email_and_password_missing"
  message :invalid_credentials_msg, "omniauth.invalid_credentials"

  def sign_in_with(email, password)
    email_field.set email
    password_field.set password
    sign_in_btn.click
  end

end
