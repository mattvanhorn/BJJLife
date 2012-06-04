class CommentsController < ApplicationController
  before_filter :authenticate_user!

  expose(:post)
  expose(:comment) { find_comment }

  def create
    comment.save!
    analytical.event 'comment', :post_id => post.id, :post => post.title
    redirect_to post_path(comment.post)
  end

  private

  def find_comment
    post.new_comment(params[:comment]).tap{|comment| comment.user_id = current_user.id}
  end

end


