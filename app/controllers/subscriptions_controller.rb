class SubscriptionsController < ApplicationController
  respond_to :html

  expose(:subscription)
  expose(:videos) { Video.scoped.sample(3) }

  def new

  end

  def create
    if subscription.save
      finished("message", :reset => false)
      analytical.event :signup, :email => subscription.email
      analytical.identify subscription.email
    end
    respond_with subscription, :location => thanks_subscriptions_url
  end

  private

  def email
    @email ||= (subscription.valid? && subscription.email.to_s)
  end
  helper_method :email
end