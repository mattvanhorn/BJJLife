class OmniAuth::Strategies::Identity
  def callback_phase
    unless identity
      return fail!('omniauth.email_and_password_missing') if missing_credentials?
      return fail!('omniauth.email_missing') if missing_email?
      return fail!('omniauth.password_missing') if missing_password?
      return fail!('omniauth.invalid_credentials')
    end
    super
  end

  private

  def missing_credentials?
    missing_email? && missing_password?
  end

  def missing_email?
    request['auth_key'].blank?
  end

  def missing_password?
    request['password'].blank?
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :identity, :fields => [:email, :opt_in],
                      :form => SessionsController.action(:new),
                      :on_failed_registration => AccountsController.action(:new)
end

OmniAuth.config.on_failure = SessionsController.action(:failure)

