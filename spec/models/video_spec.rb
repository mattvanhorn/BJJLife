# == Schema Information
#
# Table name: videos
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  url           :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  thumbnail_url :string(255)
#  state         :string(255)     default("pending")
#  up_votes      :integer         default(0), not null
#  down_votes    :integer         default(0), not null
#

require 'spec_helper'

describe Video do
  include NullDB::RSpec::NullifiedDatabase

  let(:video){ Video.new(:name => 'Test') }

  subject{ video }

  it "should not reek" do
    get_source_file(__FILE__).should_not reek
  end

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
  
  it { should_not be_published }

  it { should be_pending }

  describe "being published" do
    before(:each) do
      subject.name = "Vitor Shaolin's Brazilian Jiu Jitsu"
      subject.url = 'http://www.example.com'
    end

    it "is still pending after being saved" do
      subject.save!
      subject.should be_pending
    end

    it "can be published" do
      subject.publish!
      subject.should be_published
    end
  end

end
