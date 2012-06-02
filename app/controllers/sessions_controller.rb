require 'omni_authenticator'

class SessionsController < ApplicationController

  def create
    user = OmniAuthenticator.new(auth_hash).find_user
    sign_in(user)
    respond_with user, :location => edit_account_path
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
end