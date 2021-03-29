module Patient
  class FavouritesController < Patient::BaseController
    before_action :set_patient

    def index
      @q = Like.ransack(params[:q])
      @likes = @q.result.includes(:doctor).where(user_id: @patient.id).latest

      @pagy, @likes = pagy(@likes)
    end

    private

    def set_patient
      @patient = User.where(id: current_user.id)&.first
    end
  end
end
