class Site
  def self.navigation
    home_page.navigation
  end

  def self.current_page
    @current_page
  end

  def self.checkout_page
    @current_page = NewOrderPage.new
  end

  def self.method_missing(meth_name, *args)
    admin_pattern = /admin_page$/
    klass = if meth_name =~ admin_pattern
      "Admin::#{meth_name.to_s.gsub(admin_pattern,'page').classify}"
    else
      meth_name.to_s.classify
    end
    @current_page = klass.constantize.new
  end
end
