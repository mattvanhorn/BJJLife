class CommentsController < ApplicationController
  before_filter :authenticate_user!

  expose(:post, :strategy => UserAuthoredStrategy)
  expose(:comments){ post.comments }
  expose(:comment, :strategy => UserAuthoredStrategy)

  def create
    comment.save!
    analytical.event 'comment', :post_id => post.id, :post => post.title
    exhibit_exposed :post, :comments, :comment
    redirect_to post_path(comment.post)
  end

end


