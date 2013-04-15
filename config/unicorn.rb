rails_env = ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'production'

worker_processes (rails_env == 'production' ? 4 : 1) # amount of unicorn workers to spin up
timeout 30
preload_app true
