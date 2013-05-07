require 'active_record'
require 'yaml'
require 'support/rails_minimum'

dbconfig = YAML::load(ERB.new(File.read("#{RAILS_ROOT}/config/database.yml")).result)
ActiveRecord::Base.configurations = dbconfig

require 'nulldb_rspec'
NullDB.configure {|ndb| def ndb.project_root;RAILS_ROOT;end}
