class BlogsController < ApplicationController
  expose(:blog){ Blog.first }

  def show
    exhibit_exposed :blog
  end

end