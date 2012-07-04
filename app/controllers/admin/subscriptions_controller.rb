class Admin::SubscriptionsController < Admin::BaseController
  expose(:subscriptions){ Subscription.all }
  def index
    # exhibit_exposed :subscriptions
  end
end
