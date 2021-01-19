module Admin
  class DataController < Admin::BaseController
    include MasterData

    def index
    end

    def doctor_names
      @doctors = Doctor.pluck(:name)

      respond_to do |format|
        format.json do
          render json: @doctors.as_json
        end
      end
    end
  end
end
