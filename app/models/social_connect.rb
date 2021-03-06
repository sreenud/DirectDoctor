class SocialConnect < ApplicationRecord
  belongs_to :user

  ["facebook", "google_oauth2", "twitter", "linkedin"].each do |provider|
    scope provider, -> { where(provider: provider) }
  end
end
