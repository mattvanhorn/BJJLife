require 'spec_helper'
require 'carrierwave/test/matchers'

describe ProductPhotoUploader do
  include CarrierWave::Test::Matchers

  let(:product){ mock_model(Product, :id => 1234) }
  let(:uploader){ ProductPhotoUploader.new(product, :photo) }

  subject { uploader }

  before do
    ProductPhotoUploader.enable_processing = true
    uploader.store!(File.open(File.join(Rails.root, 'spec', 'support','images','sloth.jpg')))
  end

  after do
    ProductPhotoUploader.enable_processing = false
    uploader.remove!
  end

  its(:store_dir){ should == 'carrierwave/product/photo/1234' }
  its(:extension_white_list){ should == %w(jpg jpeg gif png)}
  its(:default_url){ should == '/assets/fallback/default.png' }

  context 'the thumb version' do
    subject { uploader.thumb }
    it { should have_dimensions(220, 136) }
    its(:default_url){ should == '/assets/fallback/thumb_default.png'}
    # more example matchers:
    # uploader.small.should be_no_larger_than(220, 220)
    # uploader.should have_permissions(0755)
  end
end



