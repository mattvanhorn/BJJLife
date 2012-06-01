Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :identity, :fields => [:email, :opt_in], :on_failed_registration => AccountsController.action(:new)
end

