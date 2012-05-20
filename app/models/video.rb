require 'active_record'
require 'open-uri'
require 'cgi'
require 'json'

class Video < ActiveRecord::Base
  attr_accessible :name, :url

  before_create :set_thumbnail_url


  private

  def set_thumbnail_url
    self.thumbnail_url = case url

    when /^http:\/\/www\.youtube\.com/
      youtube_thumb( extract_youtube_id(url))

    when /^http:\/\/vimeo\.com/
      vimeo_thumb( extract_vimeo_id(url))

    end
  end

  def extract_youtube_id(url)
    CGI.parse(URI.parse(url).query)['v'].first
  end

  def extract_vimeo_id(url)
    url.scan(/vimeo.com\/(\d+)\/?/).flatten.first
  end

  # Youtube 120x90 thumbnail image
  def youtube_thumb(code)
    "http://img.youtube.com/vi/#{code}/2.jpg" unless code.blank?
  end

  # Vimeo 150x200 thumbnail image
  def vimeo_thumb(code)
    # Make API call, parse the JSON and extract the url
    JSON.parse(open("http://vimeo.com/api/v2/video/#{code}.json").read).first['thumbnail_medium']
  end
end