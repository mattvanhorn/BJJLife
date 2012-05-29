class SubscriptionsController < ApplicationController

  expose(:subscription)
  expose(:videos) { Video.scoped.sample(3) }

  def create
    if subscription.save
      finished("message", :reset => false)
      analytical.event :signup, :email => subscription.email
      analytical.identify subscription.email
    end
    respond_with subscription, :location => thanks_subscriptions_url
  end

end