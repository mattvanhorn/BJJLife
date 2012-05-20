require 'active_record'

class Video < ActiveRecord::Base
  attr_accessible :name, :url
end