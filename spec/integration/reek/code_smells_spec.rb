require "support/reek_helper"

describe 'source code quality', :reek => true do
  Dir['lib/**/*.rb'].each do |path|
    it "reports no smells in #{path}" do
      File.new(path).should_not reek
    end
  end

  Dir['app/**/*.rb'].each do |path|
    it "reports no smells in #{path}" do
      File.new(path).should_not reek
    end
  end
end
