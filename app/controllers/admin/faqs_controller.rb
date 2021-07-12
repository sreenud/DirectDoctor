module Admin
  class FaqsController < Admin::BaseController
    before_action :set_faq, only: [:show, :edit, :update, :destroy]

    def index
      @q = Faq.ransack(params[:q])
      @faqs = @q.result.latest

      @pagy, @faqs = pagy(@faqs)
    end

    def show
    end

    def new
      @faq = Faq.new
      @statuses = Faq.statuses
    end

    def edit
      @statuses = Faq.statuses
    end

    def create
      @faq = Faq.new(faq_params)

      respond_to do |format|
        if @faq.save
          format.html { redirect_to(admin_faqs_url, notice: "Faq was successfully created.") }
          format.json { render(:show, status: :created, location: @faq) }
        else
          format.html { render(partial: "shared/partials/errors", locals: { object: @faq }, status: :bad_request) }
        end
      end
    end

    def update
      respond_to do |format|
        if @faq.update(faq_params)
          format.html { redirect_to(admin_faqs_url, notice: "Faq is successfully updated.") }
          format.json { render(:show, status: :ok, location: @faq) }
        else
          format.html { render(partial: "shared/partials/errors", locals: { object: @faq }, status: :bad_request) }
        end
      end
    end

    def destroy
      @faq.destroy
      redirect_to(admin_faqs_url)
    end

    private

    def set_tip
      @faq = Faq.find(params[:id])
    end

    def faq_params

      params.require(:faq).permit(:name, :slug, :content, :author_id, :image,
        :meta_title, :meta_description, :h1_tag, :status)
    end
  end
end
