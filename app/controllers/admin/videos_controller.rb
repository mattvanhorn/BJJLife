class Admin::VideosController < ApplicationController
  expose :video

  def index
    # just render
  end

  def new
    # just render
  end

  def create
    video.save
    respond_with :admin, video
  end

  def destroy
    video.destroy
    respond_with :admin, video
  end
end