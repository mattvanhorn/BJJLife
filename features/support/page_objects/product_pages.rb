module Admin
  class ProductsPage < SitePrism::Page
    URL = Rails.application.routes.url_helpers.admin_products_path
    set_url URL
    set_url_matcher %r(#{URL})

    elements :products, "table#products tr.product"
  end

  class NewProductPage < SitePrism::Page
    URL = Rails.application.routes.url_helpers.new_admin_product_path
    set_url URL
    set_url_matcher %r(#{URL})

    element :name_field,  "input[name='product[name]']"
    element :price_field, "input[name='product[price]']"
    element :photo_field, "input[name='product[photo]']"
    element :category_select, "select[name='product[category_id]']"
    element :create_btn, "input[name='commit']"

    def add_a_product
      load
      name_field.set "Loro Private"
      price_field.set "12000"
      photo_field.set File.join(::Rails.root, "features", "support", "images", "sloth.jpg")
      #  # NO CATEGORIES SET UP YET IN TEST ENV
      create_btn.click
    end
  end

  class EditProductPage < SitePrism::Page
    set_url "/admin/products{/product_id}/edit"
    set_url_matcher /\/admin\/products\/\d+\/edit/

    element :category_select, "select[name='product[category_id]']"
    element :update_btn, "input[name='commit']"

    def update_product_category(category)
      category_select.select(category)
      update_btn.click
    end
  end
end

class ProductPage < SitePrism::Page
  set_url "/products{/product_id}"
  set_url_matcher /\/products\/\d+/

  element :product_name, "h3.name"
  element :product_price, ".sidebar p.price"
  element :buy_btn, ".buy .btn"
end

class ProductsPage < SitePrism::Page
  set_url "/products"
  set_url_matcher %r(/products/?$)

  elements :products, "#carousel .product"
  elements :categories, "#pager a"
  elements :detail_links, ".product em a"
  elements :buy_links, ".product > a"

  def has_product?(product)
    !!products.detect{|p| p.has_text? product.name}
  end

end
