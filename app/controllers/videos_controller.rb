class VideosController < ApplicationController
  respond_to :html

  expose(:videos) { Video.all }

end

