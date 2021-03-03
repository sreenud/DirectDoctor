class ClaimProfileAttachment < ApplicationRecord
  include ImageUploader::Attachment(:image)
end
