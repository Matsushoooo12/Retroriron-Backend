CarrierWave.configure do |config|
    if Rails.env.production?
      config.storage :fog
      config.fog_provider = 'fog/aws'
      config.fog_directory  = 's3-practice02'
      config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
        region: ENV['AWS_REGION'],
        path_style: true
      }
    else
      config.storage :file
      config.enable_processing = false if Rails.env.test?
    end
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/