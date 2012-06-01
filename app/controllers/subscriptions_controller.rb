class SubscriptionsController < ApplicationController
  expose(:subscription)
  expose(:videos) { Video.scoped.sample(3) }

  def new
    # just render
  end

  def create
    if subscription.save
      finished("image", :reset => false)
      analytical.event :subscribe, :email => subscription.email
      analytical.identify subscription.email
    end
    respond_with subscription, :location => thanks_subscriptions_url
  end
end