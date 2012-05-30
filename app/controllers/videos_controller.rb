class VideosController < ApplicationController
  expose(:videos) { Video.all }

  def index
    # just render
  end
end

