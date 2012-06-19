require 'cucumber/rspec/doubles'
Before do
  $rollout.stub(:active? => true)
end
