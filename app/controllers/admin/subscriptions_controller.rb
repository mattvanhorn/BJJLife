class Admin::SubscriptionsController < ApplicationController

  private

  def subscriptions
    Subscription.all
  end
  helper_method :subscriptions
end