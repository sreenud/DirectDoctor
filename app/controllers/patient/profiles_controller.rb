module Patient
  class ProfilesController < Patient::BaseController
    before_action :valid_patient?, only: [:show, :edit, :update]
    before_action :set_patient, only: [:show, :edit, :update, :account_delete]

    def edit
    end

    def update
      respond_to do |format|
        if @patient.update(user_params)
          format.html { redirect_to(edit_patient_profile_url(@patient), notice: "Profile is successfully updated.") }
          format.json { render(:show, status: :ok, location: @patient) }
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @patient }, status: :bad_request)
          end
        end
      end
    end

    def account_delete
      if current_user
        @patient = User.find(current_user.id)
        User.find(current_user.id).destroy

        PatientMailer.with(patient: @patient, by: current_user.full_name).deleted.deliver_now

        render(json: { success: true })
      end
    end

    private

    def set_patient
      @patient = User.where(id: params[:id])&.first
    end

    def valid_patient?
      user_id = User.find_by_id(current_user.id)&.id

      redirect_to(root_path) unless user_id == params[:id].to_i
    end

    def user_params
      params.require(:user).permit(:full_name)
    end
  end
end
