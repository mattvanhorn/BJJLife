require "application_responder"

class ApplicationController < ActionController::Base
  include DisplayCase::ExhibitsHelper

  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery

  analytical  :modules => [:console, :google, :mixpanel],
              :use_session_store => true,
              :disable_if => lambda{|controller| controller.class.ancestors.include?(Admin)}

  before_filter :tag_guest, :store_location, :locate_user

  helper_method :current_user, :user_signed_in?, :identifiable_user

  protected

  def current_user
    @current_user ||= User.find_by_id(session[:user_id] || cookies.signed['remember_me'])
    exhibit(@current_user) if @current_user
  end

  def guest_user
    GuestUser.new(session[:guest_id] || cookies.signed[:guest_id] || tag_guest ).tap do |guest|
      locator = Geolocator.new(cookies)
      guest.location = locator.location
      guest.market   = locator.market
    end
  end

  def identifiable_user
    current_user || guest_user
  end

  def sign_in(user)
    @current_user = user.sign_in!
    cookies.permanent.signed[:remember_me] = session[:user_id] = @current_user.id
    TrackAnalytics.new(@current_user, analytical).do_tracking
    @current_user
  end

  def sign_out
    cookies.delete :remember_me
    session[:user_id] =  @current_user = nil
  end

  def authenticate_user!
    unless user_signed_in?
      store_location
      redirect_to sign_in_url, :alert => I18n.t('omniauth.need_sign_in')
    end
  end

  def user_signed_in?
    !!(current_user)
  end

  def store_location(url = nil)
    session[:return_to] = url || request.url
  end

  def stored_location
    destination, session[:return_to] = session[:return_to], nil
    destination
  end

  private

  def tag_guest
    unless (user_signed_in? || session[:guest_id] || cookies.signed[:guest_id])
      session[:guest_id] = cookies.permanent.signed[:guest_id] = UUIDTools::UUID.random_create.to_i
    end
  end

  def locate_user
    return unless Rails.application.config.locate_users
    if user_signed_in?
      current_user.set_location(request.location) unless current_user.located?

    elsif cookies.signed[:location].blank?
      loc_hash = Location.attributes_from_gecoder_result(request.location)
      cookies.signed[:location] = loc_hash.to_yaml
    end
  end

  def exhibit_exposed(*names)
    names.each do |name|
      _resources[name] = exhibit(self.send(name))
    end
  end

end
