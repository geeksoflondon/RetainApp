CarrierWave.configure do |config|
  config.fog_credentials = {
     :provider               => 'AWS',       # required
     :aws_access_key_id      => ENV['RETAIN_AWS_KEY'],       # required
     :aws_secret_access_key  => ENV['RETAIN_AWS_SECRET'],       # required
     :region                 => ENV['RETAIN_AWS_REGION']  # optional, defaults to 'us-east-1'
   }
   config.fog_directory  = ENV['RETAIN_AWS_BUCKET'] # required
   config.fog_host       = ENV['RETAIN_AWS_URL'] # optional, defaults to nil
   config.fog_public     = true # optional, defaults to true
   config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end