require 'active_record'
require 'yaml'
require 'support/rails_minimum'

dbconfig = YAML::load(File.open("#{RAILS_ROOT}/config/database.yml"))
ActiveRecord::Base.configurations = dbconfig

require 'nulldb_rspec'
NullDB.configure {|ndb| def ndb.project_root;RAILS_ROOT;end}



