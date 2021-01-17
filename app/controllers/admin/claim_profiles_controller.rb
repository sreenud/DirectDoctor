module Admin
  class ClaimProfilesController < Admin::BaseController
    before_action :set_claim_profile_request, only: [:show, :edit, :update, :destroy]

    def show
      set_fdd_profile
    end

    def update
      doctor = Doctor.find_by_id(params[:doctor_id])
      doctor.user_id = params[:user_id]
      doctor.save(validate: false)

      @claim_profile_request.status = 'approved'
      if @claim_profile_request.save
        render(json: { message: "Profile approved", url: admin_dashboard_index_url, success: true })
      else
        render(json: { message: @claim_profile_request.errors.messages, success: false }, status: :bad_request)
      end
    end

    def destroy
      @state = ClaimProfileRequest.find(params[:id])
      @state.destroy

      redirect_to(admin_dashboard_index_url)
    end

    private

    def set_claim_profile_request
      @claim_profile_request = ClaimProfileRequest.find(params[:id])
    end

    def set_fdd_profile
      doctor_name = @claim_profile_request&.doctor_name
      if doctor_name
        @doctors = Doctor.where("name LIKE ?", "%#{doctor_name}%")
      end
    end

    def claim_profile_request_params
      params.require(:state).permit(:name)
    end
  end
end
