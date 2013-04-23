require 'active_record'
require 'geocoder'
require "geocoder/models/active_record"
::ActiveRecord::Base.extend(Geocoder::Model::ActiveRecord)
