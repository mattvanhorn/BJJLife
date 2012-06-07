CarrierWave.configure do |carrierwave|
  carrierwave.root = Rails.root.join('tmp')
  carrierwave.cache_dir = 'carrierwave'

  carrierwave.fog_credentials = {
     :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID'],
     :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
     :provider => 'AWS',
     :region => ENV['S3_REGION']
   }
   carrierwave.fog_directory = ENV['S3_BUCKET']
   carrierwave.fog_public = true
end
