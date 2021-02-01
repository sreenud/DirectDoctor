module Admin
  class LocationsController < Admin::BaseController
    before_action :set_state
    before_action :set_location, only: [:show, :edit, :update, :destroy]

    def index
      @q = @state.locations.ransack(params[:q])
      @locations = @q.result.by_name

      @pagy, @locations = pagy(@locations)
    end

    def show
    end

    def new
      @location = Location.new
    end

    def edit
    end

    def create
      @location = Location.new(location_params)

      respond_to do |format|
        if @location.save
          format.html { redirect_to(admin_locations_url, notice: 'Location was successfully created.') }
          format.json { render(:show, status: :created, location: @location) }
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @location }, status: :bad_request)
          end
        end
      end
    end

    def update
      respond_to do |format|
        if @location.update(location_params)
          format.html { redirect_to(admin_locations_url, notice: 'Location is successfully updated.') }
          format.json { render(:show, status: :ok, location: @location) }
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @location }, status: :bad_request)
          end
        end
      end
    end

    def destroy
      @location = Location.find(params[:id])
      @location.destroy

      redirect_to(admin_locations_url)
    end

    private

    def set_state
      @state = State.find_by_id(params[:state_id])
    end

    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:name)
    end
  end
end
