class VideosController < ApplicationController

  before_filter :authenticate_user!, :except => [:index]

  expose(:videos){ Video.by_rating }
  expose(:video)

  def index
    # just render
  end

  def new
    # just render
  end

  def create
    video.publish!
    respond_with video
  end

  def upvote
    current_user.up_vote! video
    respond_with video
  end

  def downvote
    current_user.down_vote! video
    respond_with video
  end
end

