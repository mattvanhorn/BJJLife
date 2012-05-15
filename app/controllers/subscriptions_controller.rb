class SubscriptionsController < ApplicationController
  respond_to :html

  def create
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save
      finished("message", :reset => false)
      analytical.event :signup, :email => @subscription.email
    end
    respond_with @subscription, :location => thanks_subscriptions_url
  end

  private

  def subscription
    @subscription ||= Subscription.new
  end
  helper_method :subscription

  def email
    @email ||= (subscription.valid? && subscription.email.to_s)
  end
  helper_method :email
end