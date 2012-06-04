class PostsController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]

  expose(:blog){ Blog.first }
  expose(:post){ PostDecorator.decorate(find_post) }
  expose(:comment){ find_post.new_comment }

  def new
    # just render
  end

  def create
    post.publish!
    analytical.event 'publish', :blog=>:post.blog_name
    respond_with post, :location => blog_path(post.blog), :notice => "Post added!"
  end

  def show
    analytical.event 'view comments', :post_id => post.id
    # just render
  end

  private

  def find_post
    if post_id
      # show
      Post.find(post_id)
    else
      # new, create
      blog.new_post((params[:post]||{}).merge(:user_id => current_user.id))
    end
  end

  def post_id
    params[:id] || params[:post_id]
  end
end