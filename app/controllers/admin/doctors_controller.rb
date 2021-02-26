module Admin
  class DoctorsController < Admin::BaseController
    include DoctorParams
    include DoctorFormData

    before_action :set_doctor, only: [:show, :edit, :update]
    before_action :set_master_data, only: [:edit, :new]

    def index
      @q = Doctor.includes(:created).ransack(params[:q])
      @doctors = @q.result.latest

      @pagy, @doctors = pagy(@doctors)
    end

    def show
    end

    def new
      new_doctor_object
    end

    def edit
      @approvel_request = ApprovalRequest&.where(request_user_id: @doctor.user_id, status: 'pending')&.first
      if @approvel_request
        @data_changes = @approvel_request.data_changes.map { |key, data| { key => data.last } }.reduce(:merge)
        @doctor.attributes = @data_changes
      end
    end

    def create
      @doctor = Doctor.new(doctor_params)
      @doctor.created_by = current_user.id
      respond_to do |format|
        if @doctor.save
          format.html { redirect_to(admin_doctors_url, notice: 'Doctor was successfully created.') }
          format.json { render(:show, status: :created, location: @doctor) }
        else
          format.html { render(partial: "shared/partials/errors", locals: { object: @doctor }, status: :bad_request) }
        end
      end
    end

    def update
      respond_to do |format|
         @doctor.updated_by = current_user.id
        if @doctor.update(doctor_params)
          if doctor_params[:update_request] == "yes"
            request = ApprovalRequest&.where(request_user_id: @doctor.user_id, status: 'pending')&.first
            request.respond_user_id = current_user.id
            request.status = ApprovalRequest.statuses[:approved]
            request.save
          end
          format.html { redirect_to(admin_doctors_url, notice: 'Doctor is successfully updated.') }
          format.json { render(:show, status: :ok, location: @doctor) }
        else
          format.html { render(partial: "shared/partials/errors", locals: { object: @doctor }, status: :bad_request) }
        end
      end
    end

    private

    def set_doctor
      @doctor = Doctor.find(params[:id])
    end
  end
end
