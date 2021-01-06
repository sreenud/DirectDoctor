module Admin
  class DashboardController < Admin::BaseController
    def index
      @claim_profile_requests = ClaimProfileRequest.includes(:user).latest
    end
  end
end
