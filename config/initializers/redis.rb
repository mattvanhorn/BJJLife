uri = URI.parse(ENV['REDISTOGO_URL'])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :username => uri.user)

Geocoder.configure(
  # caching (see below for details):
  :cache => REDIS,
  :cache_prefix => "geocoder"
)
