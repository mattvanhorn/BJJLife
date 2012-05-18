require_relative '../../app/models/video'

describe Video do
  let(:video){ Video.new }
  subject{ video }
  it "can read and write a name field" do
    video.name = 'Foobar'
    video.name.should == 'Foobar'
  end

  it "can read and write a URL field" do
    video.url = 'Foobar'
    video.url.should == 'Foobar'
  end

  it "can accept an attributes hash" do
    v = Video.new(:name => 'Foo', :url => 'Bar')
    v.name.should == 'Foo'
    v.url.should == 'Bar'
  end
end
