class Admin::SubscriptionsController < Admin::BaseController
  expose(:subscriptions){ Subscription.all }

end