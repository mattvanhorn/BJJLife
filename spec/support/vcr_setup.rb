require 'vcr'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = File.join(Rails.root, 'spec', 'support', 'fixtures', 'vcr_cassettes')
  c.hook_into :webmock # or :fakeweb
  c.configure_rspec_metadata!
end