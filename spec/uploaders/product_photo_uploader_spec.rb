require 'spec_helper'

describe ProductPhotoUploader do
  before(:each) do
    subject.stub(:model => mock_model(Product, :id => '1234'), :mounted_as => 'photo')
  end
  its(:store_dir){ should == 'carrierwave/product/photo/1234' }
  its(:extension_white_list){ should == %w(jpg jpeg gif png)}
end
