module Admin
  class DoctorDegreesController < Admin::BaseController
    before_action :set_doctor_degree, only: [:show, :edit, :update, :destroy]

    def index
      @q = DoctorDegree.ransack(params[:q])
      @doctor_degrees = @q.result.latest

      @pagy, @doctor_degrees = pagy(@doctor_degrees)
    end

    def show
    end

    def new
      @doctor_degree = DoctorDegree.new
    end

    def edit
    end

    def create
      @doctor_degree = DoctorDegree.new(doctor_degree_params)

      respond_to do |format|
        if @doctor_degree.save
          format.html { redirect_to(admin_doctor_degrees_url, notice: 'Doctor degree was successfully created.') }
          format.json { render(:show, status: :created, location: @doctor_degree) }
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @doctor_degree }, status: :bad_request)
          end
        end
      end
    end

    def update
      respond_to do |format|
        if @doctor_degree.update(doctor_degree_params)
          format.html { redirect_to(admin_doctor_degrees_url, notice: 'Doctor degree is successfully updated.') }
          format.json { render(:show, status: :ok, location: @doctor_degree) }
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @doctor_degree }, status: :bad_request)
          end
        end
      end
    end

    def destroy
      @doctor_degree = DoctorDegree.find(params[:id])
      @doctor_degree.destroy

      redirect_to(admin_doctor_degrees_url)
    end

    private

    def set_doctor_degree
      @doctor_degree = DoctorDegree.find(params[:id])
    end

    def doctor_degree_params
      params.require(:doctor_degree).permit(:code, :name)
    end
  end
end
