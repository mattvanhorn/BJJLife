require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery

  analytical :modules => [:console, :google, :mixpanel], :use_session_store => true, :disable_if => lambda{|controller| controller.class.ancestors.include?(Admin)}

  before_filter :init_blog, :tag_guest, :store_location

  helper_method :current_user, :user_signed_in?, :identifiable_user

  protected

  def current_user
    @current_user ||= User.find_by_id(session[:user_id] || cookies.signed['remember_me'])
    UserDecorator.decorate(@current_user)
  end

  def guest_user
    GuestUser.new(session[:guest_id] || cookies.signed[:guest_id] || tag_guest )
  end

  def identifiable_user
    current_user.model || guest_user
  end

  def sign_in(user)
    @current_user = user.sign_in!
    cookies.permanent.signed[:remember_me] = session[:user_id] = @current_user.id
    do_tracking
  end

  def sign_out
    cookies.delete :remember_me
    session[:user_id] =  @current_user = nil
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
    end
  end

  def authenticate_user!
    unless user_signed_in?
      store_location
      redirect_to sign_in_url, :alert => I18n.t('omniauth.need_sign_in')
    end
  end

  def user_signed_in?
    !!(current_user.model)
  end

  def store_location(url = nil)
    session[:return_to] = url || request.url
  end

  def stored_location
    destination, session[:return_to] = session[:return_to], nil
    destination
  end

  def do_tracking
    track_sign_in
    track_sign_up
    track_subscription
  end

  def track_sign_in
    return unless user_signed_in?
    analytical.event :sign_in, :id => current_user.id
  end

  def track_sign_up
    return unless sign_up?
    analytical.event :sign_up, :id => current_user.id
  end

  def track_subscription
    return unless sign_up?
    analytical.event :subscribe, :email => current_user.subscribed_email if current_user.has_new_subscription?
  end

  def sign_up?
    user_signed_in? && current_user.first_sign_in?
  end

  private

  def init_blog
    @blog = Blog.new(:title => "Training")
  end

  def tag_guest
    unless (user_signed_in? || session[:guest_id] || cookies.signed[:guest_id])
      session[:guest_id] = cookies.permanent.signed[:guest_id] = UUIDTools::UUID.random_create.to_i
    end
  end
end
