class PostsController < ApplicationController

  before_filter :authenticate_user!

  expose(:blog){ Blog.first }
  expose(:post){ blog.new_post((params[:post]||{}).merge(:user_id => current_user.id)) }

  def new
    # just render
  end

  def create
    post.publish!
    respond_with post, :location => blog_path(post.blog), :notice => "Post added!"
  end
end