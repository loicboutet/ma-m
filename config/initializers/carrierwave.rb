ENV['AWS_ACCESS_KEY_ID'] = 'AKIAI6LGB3C5RTZJ3T2Q'
ENV['AWS_SECRET_ACCESS_KEY'] = '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'
ENV['AWS_REGION'] = 'eu-central-1'
ENV["S3_BUCKET_NAME"] = 'monartisanetmoi'

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              "AWS",
    aws_access_key_id:     ENV["AWS_ACCESS_KEY_ID"],
    aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
    region:                "eu-central-1",
 }
 config.fog_directory = ENV["S3_BUCKET_NAME"]
 config.fog_public    = true
 config.storage       = :fog
end
