class VideosController < ApplicationController

  before_filter :authenticate_user!, :except => [:index]

  expose(:videos){ Video.by_rating }
  expose(:video)

  def index
    # exhibit_exposed :videos
  end

  def new
    # exhibit_exposed :video
  end

  def create
    video.publish!
    # exhibit_exposed :video
    respond_with video
  end

  def upvote
    current_user.up_vote! video
    # exhibit_exposed :videos
    respond_with video
  end

  def downvote
    current_user.down_vote! video
    # exhibit_exposed :videos
    respond_with video
  end
end

