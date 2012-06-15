class PostsController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]

  expose(:blog){ Blog.first }
  expose(:posts){ blog.entries }
  expose(:post, :strategy => UserAuthoredStrategy)
  expose(:comment){ post.new_comment }

  def new
    exhibit_exposed :blog, :post
  end

  def create
    post.publish!
    exhibit_exposed :blog, :posts, :post

    analytical.event 'publish', :blog => post.blog_name
    respond_with post, :location => blog_path(post.blog), :notice => "Post added!"
  end

  def show
    analytical.event 'view comments', :post_id => post.id
    exhibit_exposed :blog, :post, :comment
  end

end