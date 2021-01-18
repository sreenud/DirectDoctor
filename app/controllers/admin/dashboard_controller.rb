module Admin
  class DashboardController < Admin::BaseController
    def index
      @claim_profile_requests = ClaimProfileRequest.includes(:user)
        .where('status != ?', 'approved').latest
    end
  end
end
