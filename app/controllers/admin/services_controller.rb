module Admin
  class ServicesController < Admin::BaseController
    before_action :set_service, only: [:show, :edit, :update, :destroy]

    def index
      @q = Service.ransack(params[:q])
      @services = @q.result.latest

      @pagy, @services = pagy(@services)
    end

    def show
    end

    def new
      @service = Service.new
    end

    def edit
    end

    def create
      @service = Service.new(service_params)

      respond_to do |format|
        if @service.save
          format.html { redirect_to(admin_services_url, notice: 'Service was successfully created.') }
          format.json { render(:show, status: :created, location: @service) }
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @service }, status: :bad_request)
          end
        end
      end
    end

    def update
      respond_to do |format|
        if @service.update(service_params)
          format.html { redirect_to(admin_services_url, notice: 'Service is successfully updated.') }
          format.json { render(:show, status: :ok, location: @service) }
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @service }, status: :bad_request)
          end
        end
      end
    end

    def destroy
      @service = Service.find(params[:id])
      @service.destroy

      redirect_to(admin_services_url)
    end

    private

    def set_service
      @service = Service.find(params[:id])
    end

    def service_params
      params.require(:service).permit(:name)
    end
  end
end
