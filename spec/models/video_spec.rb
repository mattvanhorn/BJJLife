require 'active_record'
require 'nulldb_rspec'
require 'nulldb/rails'

require_relative '../support/vcr_setup'
require_relative '../../app/models/video'

class Rails
  def self.root; File.expand_path('../../..', __FILE__); end
end

describe Video do
  include NullDB::RSpec::NullifiedDatabase

  let(:video){ Video.new(:name => 'Test') }

  subject{ video }

  it "sets the thumbnail url when saving a youtube video url" do
    subject.url = "http://www.youtube.com/watch?v=m0fH_8kv7ac"
    subject.save
    subject.thumbnail_url.should == "http://img.youtube.com/vi/m0fH_8kv7ac/2.jpg"
  end

  it "sets the thumbnail url when saving a vimeo video url" do
    VCR.use_cassette('vimeo_api_resp') do
      subject.url = "http://vimeo.com/19850565"
      subject.save
      subject.thumbnail_url.should == "http://b.vimeocdn.com/ts/126/328/126328224_200.jpg"
    end
  end


end
