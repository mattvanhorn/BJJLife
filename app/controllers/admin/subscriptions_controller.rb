class Admin::SubscriptionsController < ApplicationController
  before_filter :authenticate
  private

  def subscriptions
    Subscription.all
  end
  helper_method :subscriptions
end