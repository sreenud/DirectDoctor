module Admin
  class PageRedirectsController < Admin::BaseController
    before_action :set_page_redirect, only: [:show, :edit, :update, :destroy, :skills]

    def index
      @q = PageRedirect.ransack(params[:q])
      @page_redirects = @q.result.latest

      @pagy, @page_redirects = pagy(@page_redirects)
    end

    def show
    end

    def new
      @page_redirect = PageRedirect.new
      @redirect_codes = PageRedirect.codes
    end

    def edit
      @redirect_codes = PageRedirect.codes
    end

    def create
      @page_redirect = PageRedirect.new(page_redirect_params)
      @page_redirect.user_id = current_user&.id

      respond_to do |format|
        if @page_redirect.save
          format.html { redirect_to admin_page_redirects_url, notice: 'Topic was successfully created.' }
          format.json { render :show, status: :created, location: @page_redirect }
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @page_redirect }, status: :bad_request)
          end
        end
      end
    end

    def update
      respond_to do |format|
        if @page_redirect.update(page_redirect_params)
          format.html { redirect_to admin_page_redirects_url, notice: 'Topic is successfully updated.' }
          format.json { render :show, status: :ok, location: @page_redirect }
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @page_redirect }, status: :bad_request)
          end
        end
      end
    end

    def destroy
      @page_redirect = PageRedirect.find(params[:id])
      @page_redirect.destroy

      redirect_to(admin_page_redirects_url)
    end

    private

    def set_page_redirect
      @page_redirect = PageRedirect.find(params[:id])
    end

    def page_redirect_params
      params.require(:page_redirect).permit(:old, :new, :redirect_code, :comments)
    end
  end
end
