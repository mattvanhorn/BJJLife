# == Schema Information
#
# Table name: videos
#
#  id            :integer         not null, primary key
#  name          :string(255)     not null
#  url           :string(255)     not null
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  thumbnail_url :string(255)
#  state         :string(255)     default("pending")
#  up_votes      :integer         default(0), not null
#  down_votes    :integer         default(0), not null
#

require 'active_record'
require 'open-uri'
require 'cgi'
require 'json'
require 'moderatable'
require 'confidence_interval'

class Video < ActiveRecord::Base
  include Moderatable
  include ConfidenceInterval
  make_voteable

  attr_accessible :name, :url

  validates_presence_of :name, :url

  before_create :set_thumbnail_url


  private

  def set_thumbnail_url
    self.thumbnail_url = youtube_thumb if youtube?
    self.thumbnail_url = vimeo_thumb if vimeo?
  end

  def youtube?
    url =~ /^http:\/\/www\.youtube\.com/
  end

  def vimeo?
    url =~ /^http:\/\/vimeo\.com/
  end

  def extract_youtube_id
    CGI.parse(URI.parse(url).query)['v'].first
  end

  def extract_vimeo_id
    url.scan(/vimeo.com\/(\d+)\/?/).flatten.first
  end

  # Youtube 120x90 thumbnail image
  def youtube_thumb
    code = extract_youtube_id
    "http://img.youtube.com/vi/#{code}/2.jpg" unless code.blank?
  end

  # Vimeo 150x200 thumbnail image
  def vimeo_thumb
    # Make API call, parse the JSON and extract the url
    JSON.parse(open("http://vimeo.com/api/v2/video/#{extract_vimeo_id}.json").read).first['thumbnail_medium']
  end
end
