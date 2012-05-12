class SubscriptionsController < ApplicationController
  respond_to :html

  def create
    @subscription = Subscription.new(params[:subscription])
    @subscription.save
    respond_with @subscription, :location => thanks_subscriptions_url
  end

  private

  def subscription
    @subscription ||= Subscription.new
  end
  helper_method :subscription

end