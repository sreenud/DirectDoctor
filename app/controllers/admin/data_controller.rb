module Admin
  class DataController < Admin::BaseController
    def index
    end

    def degree
      @degree = DoctorDegree.pluck(:code)

      respond_to do |format|
        format.json do
          render json: @degree.as_json
        end
      end
    end

    def holistic_medicine
      @holistic = ['Payment included in membership', 'Available for an additional fee']

      respond_to do |format|
        format.json do
          render json: @holistic.as_json
        end
      end
    end

    def services
      @services = Service.pluck(:name)

      respond_to do |format|
        format.json do
          render json: @services.as_json
        end
      end
    end

    def languages
      @languages = Language.pluck(:name)

      respond_to do |format|
        format.json do
          render json: @languages.as_json
        end
      end
    end
  end
end
