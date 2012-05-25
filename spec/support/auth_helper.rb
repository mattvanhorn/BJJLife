module AuthHelper
  # do admin login
  def admin_login
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(ENV['ADMIN_USERNAME'], ENV['ADMIN_PASSWORD'])
  end
end