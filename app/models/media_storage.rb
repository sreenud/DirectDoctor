class MediaStorage < ApplicationRecord
  include ImageUploader::Attachment(:image)
end
