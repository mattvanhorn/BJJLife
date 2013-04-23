unless ENV['TDDIUM']
  require 'simplecov'
  SimpleCov.start 'rails' do
    add_group "Exhibits", "app/exhibits"
    add_group "Uploaders", "app/uploaders"
    add_group "Mailers", "app/mailers"
  end
end

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'nulldb_rspec'
require 'shoulda-matchers'

RSpec.configure do |specs|
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  specs.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  specs.infer_base_class_for_anonymous_controllers = false

  specs.before(:each){ $rollout.stub(:active? => true) }
end

require 'support/auth_helper'
require 'support/custom_matchers'
require 'support/constant_stubbing'
require 'support/vcr_setup'
require 'support/fabrication'
