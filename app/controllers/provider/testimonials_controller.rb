module Provider
  class TestimonialsController < Provider::BaseController
    before_action :valid_doctor?
    before_action :set_doctor
    before_action :set_testimonial, only:[:show, :edit, :update]

    def index
      @q = DoctorTestimonial.ransack(params[:q])
      @testimonials = @q.result.where(testimonial_by: current_user&.doctor&.id).latest

      @pagy, @testimonials = pagy(@testimonials)
    end

    def show
    end

    def new
      @testimonial = DoctorTestimonial.new
      if params[:fdd_id].present?
        @to_doctor = Doctor.find_by_fdd_id(params[:fdd_id])
      else
        @doctors = Doctor.published
      end
    end

    def edit
      @to_doctor = Doctor.find_by_id(@testimonial&.testimonial_to)
    end

    def create
      @testimonal = DoctorTestimonial.new(testimonial_params)
      @testimonal.testimonial_by = @doctor.id

      respond_to do |format|
        if @testimonal.save
          format.html do
            redirect_to(provider_testimonials_url,  notice: 'Testimonial is submitted')
          end
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @job }, status: :bad_request)
          end
        end
      end
    end

    def update
      respond_to do |format|
        if @testimonial.update(testimonial_params)
          format.html do
            redirect_to(provider_testimonials_url, notice: 'Testimonial is updated')
          end
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @testimonial }, status: :bad_request)
          end
        end
      end
    end

    def destroy
      @testimonal = DoctorTestimonial.find(params[:id])
      @testimonal.destroy

      redirect_to(provider_testimonials_url)
    end

    private

    def valid_doctor?
      redirect_to(root_path) unless current_user.has_role?('doctor')
    end

    def set_doctor
      @doctor = Doctor.find_by_id(current_user&.doctor&.id)
    end

    def set_testimonial
      @testimonial = DoctorTestimonial.find(params[:id])
    end

    def testimonial_params
      params.require(:doctor_testimonial).permit(:message, :testimonial_to)
    end
  end
end
