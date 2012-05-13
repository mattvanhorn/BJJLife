Split.redis = REDIS

Split::Dashboard.use Rack::Auth::Basic do |username, password|
  username == 'admin' && password == 'password'
end