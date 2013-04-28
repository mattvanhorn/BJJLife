module PageHelpers
  def get_page(page_name)
    @current_page = Site.send(page_name.gsub(/\s/,'_'))
  end
end
World(PageHelpers)
