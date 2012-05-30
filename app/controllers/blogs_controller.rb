class BlogsController < ApplicationController
  expose(:blog) { Blog.first }

  def show
    # just render
  end
end