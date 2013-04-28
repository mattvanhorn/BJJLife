module Admin
  class CategoriesPage < SitePrism::Page
    include CommonPageBehavior
    include IndexPageBehavior
    init_url_and_matcher(Rails.application.routes.url_helpers.admin_categories_path)
  end

  class NewCategoryPage < SitePrism::Page
    include CommonPageBehavior
    init_url_and_matcher Rails.application.routes.url_helpers.new_admin_category_path

    element :name_field, "input[name='category[name]']"
    element :create_category_btn, "input[name='commit']"

    def add_a_category
      load
      name_field.set "Products that belong to the Emperor"
      create_category_btn.click
    end

   end
end
