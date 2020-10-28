module Admin
  class DoctorsController < Admin::BaseController
    before_action :set_doctor, only: [:show, :edit, :update, :destroy, :skills]

    def index
      @q = Doctor.ransack(params[:q])
      @doctors = @q.result.latest

      @pagy, @doctors = pagy(@doctors)
    end

    def show
    end

    def new
      @doctor = Doctor.new(
        min_experience: Doctor.default_experience&.first,
        max_experience: Doctor.default_experience&.last,
        min_patients: Doctor.default_patient&.first,
        max_patients: Doctor.default_patient&.last,
        min_price: Doctor.default_price&.first,
        max_price: Doctor.default_price&.last,
      )
      @statuses = Doctor.statuses
      @doctor_degrees = DoctorDegree.latest
      @specialities = Speciality.latest
      @states = State.by_name
    end

    def edit
      @statuses = Doctor.statuses
      @doctor_degrees = DoctorDegree.latest
      @specialities = Speciality.latest
      @states = State.by_name
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

    def destroy
      @doctor = Doctor.find(params[:id])
      @doctor.destroy

      redirect_to(admin_doctors_url)
    end

    private

    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

    def doctor_params
      params.require(:doctor).permit(:title, :gender, :name, :slug, :practice_name, :style, :primary_speciality,
        :min_experience, :max_experience, :language, :is_holistic_medicine, :holistic_option,
        :is_telehealth_service, :telehealth_option, :is_home_visit, :home_visit_option, :aditional_services,
        :min_price, :max_price, :min_patients, :max_patients, :access, :appointments, :consultation,
        :free_consultation_time, :about_clinic, :about_doctor, :email, :phone, :address_line_1,
        :state, :city, :zipcode, :fax, :website_url, :disciplinary_action_taken, :fmdd_score, :image, :status,
        :lat, :lng, other_specialities: [], active_licenses: [], prices: [[:name]], social_profiles: [[:social_link]],
        education: [[:year], [:name]], certifications: [[:year], [:name]], achievements: [[:year], [:name]])
    end
  end
end
