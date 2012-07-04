require "spec_helper"

describe 'source code quality', :slow => true do
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
