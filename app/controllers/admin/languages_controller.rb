module Admin
  class LanguagesController < Admin::BaseController
    before_action :set_language, only: [:show, :edit, :update, :destroy]

    def index
      @q = Language.ransack(params[:q])
      @languages = @q.result.latest

      @pagy, @languages = pagy(@languages)
    end

    def show
    end

    def new
      @language = Language.new
    end

    def edit
    end

    def create
      @language = Language.new(language_params)

      respond_to do |format|
        if @language.save
          format.html { redirect_to(admin_languages_url, notice: "Language was successfully created.") }
          format.json { render(:show, status: :created, location: @language) }
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @language }, status: :bad_request)
          end
        end
      end
    end

    def update
      respond_to do |format|
        if @language.update(language_params)
          format.html { redirect_to(admin_languages_url, notice: "Language is successfully updated.") }
          format.json { render(:show, status: :ok, location: @language) }
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @language }, status: :bad_request)
          end
        end
      end
    end

    def destroy
      @language = Language.find(params[:id])
      @language.destroy

      redirect_to(admin_languages_url)
    end

    private

    def set_language
      @language = Language.find(params[:id])
    end

    def language_params
      params.require(:language).permit(:name)
    end
  end
end
