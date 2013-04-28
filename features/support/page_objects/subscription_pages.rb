module Admin
  class SubscriptionsPage < SitePrism::Page
    include CommonPageBehavior
    init_url_and_matcher(Rails.application.routes.url_helpers.admin_subscriptions_path)

    elements :subscribers, "p.subscription"
  end
end

class SubscriptionThankYouPage < SitePrism::Page
  URL = Rails.application.routes.url_helpers.thanks_subscriptions_path
  set_url URL
  set_url_matcher %r(#{URL})

  set_message_translator do |key|
    HTML::FullSanitizer.new.sanitize I18n.t(key)
  end
  message :site_name, 'site_name'
  message :thank_you, 'subscriptions.thanks.message_html'
end
