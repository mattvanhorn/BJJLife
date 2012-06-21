class Admin::CategoriesController < Admin::BaseController
  expose :categories
  expose :category

  def index
    exhibit_exposed :categories
  end

  def new
    exhibit_exposed :category
  end

  def create
    category.save
    exhibit_exposed :categories, :category
    respond_with :admin, category
  end

  def destroy
    category.destroy
    exhibit_exposed :categories
    respond_with :admin, category
  end
end