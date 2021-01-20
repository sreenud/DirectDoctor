module Admin
  class DashboardController < Admin::BaseController
    def index
      @claim_profile_requests = ClaimProfileRequest.includes(:user)
        .where('status != ?', 'approved').latest

      @profile_update_requests = ApprovalRequest.includes(user: :doctor)
        .where(status: ApprovalRequest.statuses[:pending])
    end
  end
end
