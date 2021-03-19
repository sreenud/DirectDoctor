module Provider
  class ProfilesController < Provider::BaseController
    include DoctorParams
    include DoctorFormData

    before_action :valid_doctor?
    before_action :set_doctor, only: [:show, :edit, :update, :upload_image]
    before_action :set_master_data, only: [:edit, :new]

    def edit
    end

    def update
      @doctor.attributes = doctor_params

      @doctor.title = @doctor.json_to_string(@doctor.title)
      @doctor.language = @doctor.json_to_string(@doctor.language)
      @doctor.holistic_option = @doctor.json_to_string(@doctor.holistic_option)
      @doctor.telehealth_option = @doctor.json_to_string(@doctor.telehealth_option)
      @doctor.home_visit_option = @doctor.json_to_string(@doctor.home_visit_option)
      @doctor.aditional_services = @doctor.json_to_string(@doctor.aditional_services)
      @doctor.appointments = @doctor.json_to_string(@doctor.appointments)
      @doctor.consultation = @doctor.json_to_string(@doctor.consultation)
      @doctor.free_consultation_time = @doctor.json_to_string(@doctor.free_consultation_time)

      if @doctor.valid? && !(restricted_fields & @doctor.changed).empty?

        @approval_request = ApprovalRequest.new(
          request_user_id: current_user.id,
          params: @doctor.changes,
          data_changes: @doctor.changes,
          requested_at: Time.current,
        )

        if @approval_request.save
          redirect_to(edit_provider_profile_url(@doctor), alert: 'Profile is submitted for review.')
        end
      else
        respond_to do |format|
          if @doctor.save
            format.html { redirect_to(edit_provider_profile_url(@doctor), notice: 'Profile is successfully updated.') }
            format.json { render(:show, status: :ok, location: @doctor) }
          else
            format.html { render(partial: "shared/partials/errors", locals: { object: @doctor }, status: :bad_request) }
          end
        end
      end
    end

    def upload_image
      @doctor.attributes = doctor_params
      @doctor.save(validate: false)

      render(json: { image_url: @doctor.image_url(:medium) }, status: :ok)
    end

    private

    def set_doctor
      @doctor = Doctor.where(id: params[:id])&.first
    end

    def valid_doctor?
      doctor_id = Doctor.find_by_user_id(current_user.id)&.id

      redirect_to(root_path) unless doctor_id == params[:id].to_i
    end

    def restricted_fields
      Doctor.restricted_fields
    end
  end
end
