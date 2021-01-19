module Provider
  class ProfilesController < Provider::BaseController
    include DoctorParams
    include DoctorFormData

    before_action :valid_doctor?
    before_action :set_doctor, only: [:show, :edit, :update]
    before_action :set_master_data, only: [:edit, :new]

    def edit
    end

    def update
      respond_to do |format|
        if @doctor.update(doctor_params)
          format.html { redirect_to edit_provider_profile_url(@doctor), notice: 'Profile is successfully updated.' }
          format.json { render :show, status: :ok, location: @doctor }
        else
          format.html { render(partial: "shared/partials/errors", locals: { object: @doctor }, status: :bad_request) }
        end
      end
    end

    private

    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

    def valid_doctor?
      doctor_id = Doctor.find_by_user_id(current_user.id)&.id

      redirect_to(root_path) unless doctor_id == params[:id].to_i
    end
  end
end
