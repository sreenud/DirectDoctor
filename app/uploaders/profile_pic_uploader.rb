require('fastimage')
require 'vips'
require "image_processing/vips"

class ProfilePicUploader < Shrine
  plugin :derivation_endpoint, prefix: "derivations/image"

  THUMBNAILS = {
    large: [800, 800],
    medium: [600, 600],
    small: [300, 300],
  }

  Attacher.derivatives do |original|
    vips = ImageProcessing::Vips.source(original)
    vips = vips.crop(*file.crop_points) # apply cropping

    THUMBNAILS.transform_values do |(width, height)|
      vips.resize_to_limit!(width, height)
    end
  end

  # Default URLs of missing derivatives to on-the-fly processing.
  Attacher.default_url do |derivative: nil, **|
    next unless derivative && file

    file.derivation_url(:transform, shrine_class.urlsafe_serialize(
      crop:            file.crop_points,
      resize_to_limit: THUMBNAILS.fetch(derivative),
    ))
  end

  # Generic derivation that applies a given sequence of transformations.
  derivation :transform do |file, transformations|
    transformations = shrine_class.urlsafe_deserialize(transformations)

    vips = ImageProcessing::Vips.source(file)
    vips.apply!(transformations)
  end

  class UploadedFile
    # convenience method for fetching crop points from metadata
    def crop_points
      metadata.fetch("crop").fetch_values("x", "y", "width", "height")
    end
  end
end
