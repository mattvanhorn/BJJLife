class ProductsController < ApplicationController
  expose :products
  expose :product

  def index
    exhibit_exposed :products
  end

  def show
    exhibit_exposed :product
  end

end