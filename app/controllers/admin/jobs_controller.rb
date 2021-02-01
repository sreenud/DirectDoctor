module Admin
  class JobsController < Admin::BaseController
    before_action :set_job, only: [:show, :edit, :update, :destroy]

    def index
      @q = Job.ransack(params[:q])
      @jobs = @q.result.includes(:doctor).latest

      @pagy, @jobs = pagy(@jobs)
    end

    def show
    end

    def new
      @job = Job.new

      @doctors = Doctor.all
      @specialities = Speciality.all
    end

    def edit
      @doctors = Doctor.all
      @specialities = Speciality.all
    end

    def create
      @job = Job.new(job_params)

      respond_to do |format|
        if @job.save
          format.html { redirect_to(admin_jobs_url, notice: 'Job was successfully created.') }
          format.json { render(:show, status: :created, location: @job) }
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @job }, status: :bad_request)
          end
        end
      end
    end

    def update
      respond_to do |format|
        if @job.update(job_params)
          format.html { redirect_to(admin_jobs_url, notice: 'Job is successfully updated.') }
          format.json { render(:show, status: :ok, location: @job) }
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @job }, status: :bad_request)
          end
        end
      end
    end

    def destroy
      @job = Job.find(params[:id])
      @job.destroy

      redirect_to(admin_jobs_url)
    end

    private

    def set_job
      @job = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:doctor_id, :name, :board_certification, :hours,
        :experience, :salary, :sign_on_bonus, :paid_time_off, :loan_assistance, :health_insurence,
        :medical_insurence, :visa_sponsorship, specialities: [], degree: [[:name]])
    end
  end
end
