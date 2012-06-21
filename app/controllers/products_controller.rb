class ProductsController < ApplicationController
  before_filter :work_in_progress

  expose(:products) { Product.categorized }
  expose(:categories_in_use) { Category.in_use }
  expose :product

  def index
    exhibit_exposed :products, :categories_in_use
  end

  def show
    exhibit_exposed :product
  end

  protected

  def work_in_progress
    redirect_to root_url and return unless $rollout.active?(:shopping, identifiable_user)
  end
end