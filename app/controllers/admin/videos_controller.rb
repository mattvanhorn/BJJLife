class Admin::VideosController < ApplicationController
  respond_to :html
  expose :video

  def create
    video.save
    respond_with video, :location => admin_videos_url
  end

  def destroy
    video.destroy
    respond_with video, :location => admin_videos_url
  end
end