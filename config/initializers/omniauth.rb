class OmniAuth::Strategies::Identity
  def callback_phase
    unless identity
      return fail!('omniauth.email_and_password_missing') if (request['auth_key'].blank? && request['password'].blank?)
      return fail!('omniauth.email_missing') if request['auth_key'].blank?
      return fail!('omniauth.password_missing') if request['password'].blank?
      return fail!('omniauth.invalid_credentials')
    end
    super
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :identity, :fields => [:email, :opt_in],
                      :form => SessionsController.action(:new),
                      :on_failed_registration => AccountsController.action(:new)
end

OmniAuth.config.on_failure = SessionsController.action(:failure)

