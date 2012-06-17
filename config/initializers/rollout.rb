$rollout = Rollout.new(REDIS)
RolloutUi.wrap($rollout)

RolloutUi::Server.use Rack::Auth::Basic do |username, password|
  username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
end