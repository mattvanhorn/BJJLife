# require 'actionpack/lib/action_view/helpers/sanitize_helper.rb'

class NavigationSection < SitePrism::Section
  element :my_profile, "a[text()='My Profile']"
end

class HomePage < SitePrism::Page

  set_url '/{?image}'
  set_url_matcher /\/(?:\?image=(?:a|b))?/

  section :navigation, NavigationSection, "ul.navigation"

  element :site_logo, "#content header h1 a"
  element :banner_img, ".new_subscription .banner img"
  element :email_field, 'input[name="subscription[email]"]'
  element :subscribe_btn, 'form.new_subscription input[name="commit"]'
  element :academy_guide_link, "a[text()='#{I18n.t('subscriptions.new_stuff.academy_guide_link')}']"
  element :sign_up_form, "#new_subscription.simple_form"

  set_message_translator do |key|
    HTML::FullSanitizer.new.sanitize I18n.t(key)
  end

  message :explanation, 'subscriptions.new.explanation_html'
  message :site_name, 'site_name'

  def do_subscribe(email)
    email_field.set email
    subscribe_btn.click
  end
end
