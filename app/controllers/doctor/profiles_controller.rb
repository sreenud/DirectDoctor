module Doctor
  class ProfilesController < Doctor::BaseController
    include DoctorParams
    include DoctorFormData

    before_action :set_doctor, only: [:show, :edit, :update]
    before_action :set_master_data, only: [:edit, :new]

    def index
      @q = Doctor.ransack(params[:q])
      @doctors = @q.result.latest

      @pagy, @doctors = pagy(@doctors)
    end

    def show
    end

    def new
      new_doctor_object
    end

    def edit
    end

    def create
      @doctor = Doctor.new(doctor_params)
      respond_to do |format|
        if @doctor.save
          format.html { redirect_to admin_doctors_url, notice: 'Doctor was successfully created.' }
          format.json { render :show, status: :created, location: @doctor }
        else
          format.html { render(partial: "shared/partials/errors", locals: { object: @doctor }, status: :bad_request) }
        end
      end
    end

    def update
      respond_to do |format|
        if @doctor.update(doctor_params)
          format.html { redirect_to admin_doctors_url, notice: 'Doctor is successfully updated.' }
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
  end
end