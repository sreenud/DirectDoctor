module Provider
  class JobsController < Provider::BaseController
    before_action :set_job, only: [:show, :edit, :update, :destroy]
    before_action :set_doctor

    def index
      @q = Job.ransack(params[:q])
      @jobs = @q.result.includes(:doctor).where(doctor_id: current_user&.doctor&.id).latest

      @pagy, @jobs = pagy(@jobs)
    end

    def show
    end

    def new
      @job = Job.new

      @specialities = Speciality.all
    end

    def edit
      valid_job = Job.where(id: params[:id]).where(doctor_id: @doctor.id)
      redirect_to(provider_jobs_url) unless valid_job.present?

      @specialities = Speciality.all
    end

    def create
      @job = @doctor.jobs.build(job_params)

      respond_to do |format|
        @job.status = Job.statuses[:draft]
        if @job.save
          format.html do
            redirect_to(provider_jobs_url,
           notice: 'Thank you for submitting your job requirements.
            Our team will email you and publish the job posting after the review process (1-3days)')
          end
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
          format.html { redirect_to(provider_jobs_url, notice: 'Job is successfully updated.') }
          format.json { render(:show, status: :ok, location: @job) }
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @job }, status: :bad_request)
          end
        end
      end
    end

    def destroy
      valid_job = Job.where(id: params[:id]).where(doctor_id: @doctor.id)
      redirect_to(provider_jobs_url) unless valid_job.present?

      @job = Job.find(params[:id])
      @job.destroy

      redirect_to(admin_jobs_url)
    end

    private

    def set_doctor
      @doctor = Doctor.find_by_id(current_user&.doctor&.id)
    end

    def set_job
      @job = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:title, :board_certification, :hours,
        :experience, :salary, :sign_on_bonus, :paid_time_off, :loan_assistance, :health_insurence,
        :medical_insurence, :visa_sponsorship, :desired_skills, :description, specialities: [], degree: [[:name]])
    end
  end
end
