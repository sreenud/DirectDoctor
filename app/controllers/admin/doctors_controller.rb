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
      @doctor = Doctor.new
      @statuses = Doctor.statuses
    end

    def edit
      @statuses = Doctor.statuses
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
      params.require(:doctor).permit(:category_id, :name, :slug, :summary, :content, :is_popular,
        :author_id, :image, :meta_title, :meta_description, :h1_tag, :status, :read_time,
        :status, :tag_list, :author_id, :primary_keyword)
    end
  end
end
