Split.redis = REDIS

Split::Dashboard.use Rack::Auth::Basic do |username, password|
  username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
end