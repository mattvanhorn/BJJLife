class TrackAnalytics
  attr_reader :current_user, :analytical

  def initialize(current_user, analytical)
    @analytical = analytical
    @current_user = current_user
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

  def user_signed_in?
    !!(current_user)
  end

  def sign_up?
    user_signed_in? && current_user.first_sign_in?
  end
end


