class Admin::ProductsController < Admin::BaseController
  expose :products
  expose :product

  def index
    exhibit_exposed :products
  end

  def new
    exhibit_exposed :product
  end

  def create
    product.save
    exhibit_exposed :products, :product
    respond_with :admin, product
  end

  def edit
    exhibit_exposed :product
  end

  def update
    product.save
    exhibit_exposed :products, :product
    respond_with :admin, product
  end
end