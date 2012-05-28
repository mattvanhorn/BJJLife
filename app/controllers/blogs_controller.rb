class BlogsController < ApplicationController
  expose(:blog) { Blog.first }

end