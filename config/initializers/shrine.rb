require "shrine"
require "shrine/storage/s3"

credentials = Rails.application.credentials[Rails.env.to_sym]

s3_options = {
  bucket: credentials[:aws_s3][:bucket], # required
  access_key_id: credentials[:aws_s3][:access_key_id],
  secret_access_key: credentials[:aws_s3][:secret_access_key],
  region: credentials[:aws_s3][:region],
}

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: "production/cache", upload_options: { acl: "public-read" }, **s3_options),
  store: Shrine::Storage::S3.new(prefix: "production/", upload_options: { acl: "public-read" }, **s3_options),
}

Shrine.plugin(:activerecord)           # loads Active Record integration
Shrine.plugin(:cached_attachment_data) # enables retaining cached file across form redisplays
Shrine.plugin(:restore_cached_data)    # extracts metadata for assigned cached files
Shrine.plugin(:validation)
Shrine.plugin(:validation_helpers)
Shrine.plugin(:derivatives)
Shrine.plugin(:derivation_endpoint, secret_key: "secret")
Shrine.plugin(:upload_endpoint, url: true)
Shrine.plugin(:determine_mime_type)
Shrine.plugin(:default_url)
