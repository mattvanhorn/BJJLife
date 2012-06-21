require 'cover_me' unless ENV['TDDIUM']

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'nulldb_rspec'
require 'reek/spec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |specs|
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  specs.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  specs.infer_base_class_for_anonymous_controllers = false

  specs.include(Reek::Spec)
  specs.include(ReekHelper)

  specs.before(:each){ $rollout.stub(:active? => true) }
end

Fabrication.configure do |config|
  config.fabricator_path = ["features/support/fabricators", "spec/fabricators"]
end