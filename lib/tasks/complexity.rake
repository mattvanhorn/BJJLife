begin
  require "flog"

  desc "Analyze for total code complexity"
  task :flog do
    threshold = 1000
    flog = Flog.new
    flog.flog %w[app lib]
    flog.report
    fail "Flog total too high! #{flog.total} > #{threshold}" if flog.total > threshold
  end

  desc "Analyze for average code complexity"
  task :flog_avg do
    threshold = 25
    flog = Flog.new
    flog.flog %w[app lib]
    fail "Flog total too high! #{flog.average} > #{threshold}" if flog.average > threshold
  end

  desc "Analyze for individual code complexity"
  task :flog_each do
    threshold = 40
    flog = Flog.new
    flog.flog %w[app lib]

    bad_methods = flog.totals.select do |name, score|
      score > threshold
    end
    bad_methods.sort { |a,b| a[1] <=> b[1] }.each do |name, score|
      puts "%8.1f: %s" % [score, name]
    end
    fail "#{bad_methods.size} methods have a flog complexity >#{threshold}" unless bad_methods.empty?
  end

  desc "Runs all flog complexity metrics"
  task :complexity => [:flog_each, :flog_avg, :flog]
rescue LoadError
  # DO NOTHING - WE'RE ON HEROKU
end