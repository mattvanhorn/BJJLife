require 'omni_authenticator'

class SessionsController < ApplicationController
  skip_before_filter :store_location

  def create
    user = OmniAuthenticator.new(auth_hash).find_user
    sign_in(user)
    respond_with user, :location => destination(user)
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  def failure
    redirect_to sign_in_url, :alert => I18n.t(request.env['omniauth.error.type'])
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def destination(user)
    if user.first_sign_in?
      edit_account_path
    else
      stored_location || root_path
    end
  end
end