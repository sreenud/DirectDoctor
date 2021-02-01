module Admin
  class ReviewsController < Admin::BaseController
    before_action :set_review, only: [:show, :edit, :update, :destroy]

    def index
      @q = Review.ransack(params[:q])
      @reviews = @q.result.latest

      @pagy, @reviews = pagy(@reviews)
    end

    def show
    end

    def new
      @review = Review.new
    end

    def edit
      @statuses = Review.statuses
    end

    def create
      @review = Review.new(review_params)

      respond_to do |format|
        if @review.save
          format.html { redirect_to(admin_reviews_url, notice: 'Review was successfully created.') }
          format.json { render(:show, status: :created, location: @review) }
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @review }, status: :bad_request)
          end
        end
      end
    end

    def update
      respond_to do |format|
        if @review.update(review_params)
          # doctor save average rating
          @doctor = Doctor.find(@review.doctor_id)
          reviews = @doctor&.reviews&.published

          total_reviews = reviews ? reviews&.count : 0
          review_sum = reviews ? reviews&.sum(:rating) : 0
          @doctor.avg_rating = review_sum / total_reviews
          @doctor.save(validate: false)

          format.html { redirect_to(admin_reviews_url, notice: 'Review is successfully updated.') }
          format.json { render(:show, status: :ok, location: @review) }
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @review }, status: :bad_request)
          end
        end
      end
    end

    def destroy
      @review = Review.find(params[:id])
      @review.destroy

      redirect_to(admin_reviews_url)
    end

    private

    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:title, :review, :status)
    end
  end
end
