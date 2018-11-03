if Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false if Rails.env.test?
  end
else
  CarrierWave.configure do |config|
    config.fog_credentials = {
        provider:               'AWS',
        aws_access_key_id:      ENV['AWS_ACCESS_KEY_ID'],
        aws_secret_access_key:  ENV['AWS_SECRET_KEY_ID'],
        region:                 'ap-northeast-1'
    }
    config.storage = :fog
    config.fog_directory = Rails.application.secrets.s3[:data_bucket]
    config.fog_public = false
    config.fog_authenticated_url_expiration = 60 * 60 #second
  end
end

# see https://gist.github.com/jcsrb/1510601
module CarrierWave
  module MiniMagick
    # Rotates the image based on the EXIF Orientation
    def fix_exif_rotation
      manipulate! do |img|
        img.auto_orient
        img = yield(img) if block_given?
        img
      end
    end

    # remove Exif info
    def strip
      manipulate! do |img|
        img.strip
        img = yield(img) if block_given?
        img
      end
    end
  end
end
