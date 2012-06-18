class Admin::VideosController < Admin::BaseController
  expose :videos
  expose :video

  def index
    exhibit_exposed :videos
  end

  def new
    exhibit_exposed :video
  end

  def create
    video.save
    exhibit_exposed :videos, :video
    respond_with :admin, video
  end

  def destroy
    video.destroy
    exhibit_exposed :videos
    respond_with :admin, video
  end
end