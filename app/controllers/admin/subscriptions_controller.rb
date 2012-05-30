class Admin::SubscriptionsController < Admin::BaseController
  expose(:subscriptions){ Subscription.all }
  def index
    # just render
  end
end