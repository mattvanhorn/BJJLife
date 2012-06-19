$rollout = Rollout.new(REDIS)
RolloutUi.wrap($rollout)

RolloutUi::Server.use Rack::Auth::Basic do |username, password|
  username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
end

Rails.application.config.to_prepare do
  RolloutUi::ApplicationController.class_eval do
    skip_before_filter :init_blog, :tag_guest, :store_location
  end
end