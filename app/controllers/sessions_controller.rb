require 'omni_authenticator'

class SessionsController < ApplicationController

  def create
    user = OmniAuthenticator.new(auth_hash).find_user
    sign_in(user)
    respond_with user, :location => edit_account_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end