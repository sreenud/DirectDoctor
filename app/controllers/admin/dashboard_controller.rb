module Admin
  class DashboardController < Admin::BaseController
    def index
      @claim_profile_requests = ClaimProfileRequest.includes(:user)
        .where(status: ['requested', 'follow_up']).latest

      @profile_update_requests = ApprovalRequest.includes(user: :doctor)
        .where(status: ApprovalRequest.statuses[:pending])

      @reviews = Review.draft
    end
  end
end
