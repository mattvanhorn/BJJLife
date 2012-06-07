class ProductsController < ApplicationController
  expose :product

  def show
    exhibit_exposed :product
  end

end