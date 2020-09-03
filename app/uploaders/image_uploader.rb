require 'fastimage'
class ImageUploader < Shrine
  plugin :store_dimensions

  Attacher.validate do
    validate_mime_type %w[image/jpeg image/png image/webp]
    validate_max_size 5 * 1024 * 1024
    # validate_max_dimensions [113, 174]
  end
end
