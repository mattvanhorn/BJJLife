class ProductsController < ApplicationController
  before_filter :work_in_progress

  expose(:market) { identifiable_user.market }
  expose(:products) { Product.categorized_for(market) }
  expose(:categories_in_use) { Category.in_use }
  expose :product

  def index
    exhibit_exposed :products, :categories_in_use, :market
  end

  def show
    exhibit_exposed :product
  end

  protected

  def work_in_progress
    redirect_to root_url and return unless $rollout.active?(:shopping, identifiable_user)
  end
end