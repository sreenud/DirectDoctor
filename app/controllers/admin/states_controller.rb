module Admin
  class StatesController < Admin::BaseController
    before_action :set_state, only: [:show, :edit, :update, :destroy]

    def index
      @q = State.ransack(params[:q])
      @states = @q.result.by_code

      @pagy, @states = pagy(@states)
    end

    def show
    end

    def new
      @state = State.new
    end

    def edit
    end

    def create
      @state = State.new(state_params)

      respond_to do |format|
        if @state.save
          format.html { redirect_to(admin_states_url, notice: "State was successfully created.") }
          format.json { render(:show, status: :created, location: @state) }
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @state }, status: :bad_request)
          end
        end
      end
    end

    def update
      respond_to do |format|
        if @state.update(state_params)
          format.html { redirect_to(admin_states_url, notice: "State is successfully updated.") }
          format.json { render(:show, status: :ok, location: @state) }
        else
          format.html do
            render(partial: "shared/partials/errors", locals: { object: @state }, status: :bad_request)
          end
        end
      end
    end

    def destroy
      @state = State.find(params[:id])
      @state.destroy

      redirect_to(admin_states_url)
    end

    private

    def set_state
      @state = State.find(params[:id])
    end

    def state_params
      params.require(:state).permit(:name)
    end
  end
end
