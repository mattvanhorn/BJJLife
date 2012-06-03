class CommentsController < ApplicationController
  expose(:post)
  expose(:comment) { find_comment }

  def create
    comment.save!
    redirect_to post_path(comment.post)
  end

  private

  def find_comment
    post.new_comment(params[:comment]).tap{|comment| comment.user_id = current_user.id}
  end

end


