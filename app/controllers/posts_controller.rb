class PostsController < ApplicationController
  expose(:blog){ Blog.first }
  expose(:post){ blog.new_post(params[:post]) }

  def new
    # just render
  end

  def create
    post.publish!
    respond_with post, :location => blog_path(post.blog), :notice => "Post added!"
  end
end