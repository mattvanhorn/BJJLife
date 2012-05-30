# require 'flog'
# require 'flog_task'
#
# desc "Analyze for average code complexity"
# task :flog_avg do
#   require "flog"
#   threshold = 25
#   flog = Flog.new
#   flog.flog %w[app lib]
#   fail "Flog total too high! #{flog.average} > #{threshold}" if flog.average > threshold
# end
#
# desc "Analyze for individual code complexity"
# task :flog_each do
#   require "flog"
#   threshold = 40
#   flog = Flog.new
#   flog.flog %w[app lib]
#
#   bad_methods = flog.totals.select do |name, score|
#     score > threshold
#   end
#   bad_methods.sort { |a,b| a[1] <=> b[1] }.each do |name, score|
#     puts "%8.1f: %s" % [score, name]
#   end
#   fail "#{bad_methods.size} methods have a flog complexity >#{threshold}" unless bad_methods.empty?
# end
#
#
# FlogTask.new :flog, 1000, %w[app lib]
#
# desc "Runs flog complexity metrics"
# task :quality => [:flog_each, :flog_avg, :flog]