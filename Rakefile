#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

# Uncomment the following line to get detailed rake output on Heroku deploys
Rake.application.options.trace = true if %w(staging production).include?(Rails.env)

Bjjlife::Application.load_tasks
