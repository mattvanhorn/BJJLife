class VideosController < ApplicationController

  before_filter :authenticate_user!, :except => [:index]

  expose(:videos){ Video.all }
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

end

