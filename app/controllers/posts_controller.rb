class PostsController < ApplicationController
  expose(:blog){ Blog.first }
  expose(:post){ blog.new_post(params[:post]) }

  def create
    post.publish
    redirect_to root_path, notice: "Post added!"
  end

end