class VideosController < ApplicationController

  expose(:videos) { Video.all }

end

