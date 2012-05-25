class Admin::VideosController < ApplicationController
  expose :video

  def create
    video.save
    respond_with :admin, video
  end

  def destroy
    video.destroy
    respond_with :admin, video
  end
end