require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery

  analytical :modules => [:console, :google, :mixpanel], :use_session_store => true, :disable_if => lambda{|controller| controller.class.ancestors.include?(Admin)}

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
    end
  end
end
