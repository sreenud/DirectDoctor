module Patient
  class ReviewsController < Patient::BaseController
    before_action :set_patient, only: [:show, :edit, :update]

    def new
    end

    def create
      doctor = Doctor.find_by_id(params[:doctor_id])
      profile_url = "#{request.base_url}#{doctor.profile_url}#reviews"

      redirect_to(profile_url)
    end

    private

    def set_patient
      @patient = User.where(id: current_user.id)&.first
    end
  end
end
