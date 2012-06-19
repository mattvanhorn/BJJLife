class ProductsController < ApplicationController
  before_filter :work_in_progress

  expose :products
  expose :product

  def index
    exhibit_exposed :products
  end

  def show
    exhibit_exposed :product
  end

  protected

  def work_in_progress
    redirect_to root_url and return unless $rollout.active?(:shopping, identifiable_user)
  end
end