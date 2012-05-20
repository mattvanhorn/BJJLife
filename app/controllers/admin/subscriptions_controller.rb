class Admin::SubscriptionsController < Admin::BaseController

  private

  def subscriptions
    Subscription.all
  end
  helper_method :subscriptions
end