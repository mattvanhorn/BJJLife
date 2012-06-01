require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery

  analytical :modules => [:console, :google, :mixpanel], :use_session_store => true, :disable_if => lambda{|controller| controller.class.ancestors.include?(Admin)}

  before_filter :init_blog

  helper_method :current_user, :user_signed_in?

  protected

  def current_user
    @current_user ||= User.find_by_id(session[:user_id] || cookies.signed['remember_me'])
    UserDecorator.decorate(@current_user)
  end

  def sign_in(user)
    @current_user = user
    cookies.permanent.signed[:remember_me] = session[:user_id] = user.id
    user.sign_in!
    if user.first_sign_in?
      analytical.event :sign_up, :id => user.id
      analytical.event :subscribe, :email => user.subscribed_email if user.subscription
    end
    analytical.event :sign_in, :id => user.id
    flash[:notice] = "Signed in successfully."
  end

  def sign_out
    cookies.delete :remember_me
    session[:user_id] =  @current_user = nil
    flash[:notice] = "Signed out!"
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
    end
  end

  def authenticate_user!
    unless user_signed_in?
      store_location
      redirect_to sign_in_url, :alert => 'You need to sign in for access to this page.'
    end
  end

  def user_signed_in?
    !!(current_user.model)
  end

  def store_location(url = nil)
    session[:return_to] = url || request.url
  end

  private

  def init_blog
    @blog = Blog.new(:title => "Training")
  end
end
