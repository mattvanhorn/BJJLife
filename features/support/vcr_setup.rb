require 'vcr'
require 'webmock'

VCR.configure do |c|
  c.hook_into :webmock
  c.ignore_localhost = true
  c.cassette_library_dir = 'features/support/vcr_cassettes'
end

VCR.cucumber_tags do |t|
  t.tags  '@geocode_academy', '@geocode_academy_br', '@geocode_user','@stripe', '@vimeo', '@geocode_search_sf', '@geocode_search_ny'
  t.tag  '@vcr', :use_scenario_name => true
end
