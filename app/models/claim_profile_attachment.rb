class ClaimProfileAttachment < ApplicationRecord
  include FileUploader::Attachment(:image)
end
