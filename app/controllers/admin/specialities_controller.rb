module Admin
  class SpecialitiesController < Admin::BaseController
    before_action :set_speciality, only: [:show, :edit, :update, :destroy]

    def index
      @q = Speciality.ransack(params[:q])
      @specialities = @q.result.latest

      @pagy, @specialities = pagy(@specialities)
    end

    def show
    end

    def new
      @speciality = Speciality.new
    end

    def edit
    end

    def create
      @speciality = Speciality.new(speciality_params)

      respond_to do |format|
        if @speciality.save
          format.html { redirect_to(admin_specialities_url, notice: 'Speciality was successfully created.') }
          format.json { render(:show, status: :created, location: @speciality) }
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @speciality }, status: :bad_request)
          end
        end
      end
    end

    def update
      respond_to do |format|
        if @speciality.update(speciality_params)
          format.html { redirect_to(admin_specialities_url, notice: 'Speciality is successfully updated.') }
          format.json { render(:show, status: :ok, location: @speciality) }
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @speciality }, status: :bad_request)
          end
        end
      end
    end

    def destroy
      @speciality = Speciality.find(params[:id])
      @speciality.destroy

      redirect_to(admin_specialities_url)
    end

    private

    def set_speciality
      @speciality = Speciality.find(params[:id])
    end

    def speciality_params
      params.require(:speciality).permit(:code, :name, speciality_aliases_attributes: [:id, :name, :_destroy])
    end
  end
end
