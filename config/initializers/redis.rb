uri = URI.parse(ENV['REDISTOGO_URL'])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :username => uri.user)

Geocoder.configure do |config|
  # caching (see below for details):
  config.cache = REDIS
  config.cache_prefix = "geocoder"
end
