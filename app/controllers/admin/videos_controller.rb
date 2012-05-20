class Admin::VideosController < ApplicationController
  respond_to :html
  expose :video

  def create
    video = Video.create(params[:video])
    respond_with video, :location => admin_videos_url
  end

end