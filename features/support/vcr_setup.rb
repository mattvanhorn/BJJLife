require 'vcr'
require 'webmock'

VCR.configure do |c|
  c.hook_into :webmock
  c.ignore_localhost = true
  c.cassette_library_dir = 'features/support/vcr_cassettes'
end

VCR.cucumber_tags do |t|
  t.tag  '@vcr', :use_scenario_name => true
end