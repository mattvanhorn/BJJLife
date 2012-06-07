$rollout = Rollout.new(REDIS)
RolloutUi.wrap($rollout)

RolloutUi::Server.use Rack::Auth::Basic do |username, password|
  username == ENV['admin_username'] && password == ENV['admin_password']
end