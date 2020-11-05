module Admin
  class DataController < Admin::BaseController
    def index
    end

    def degree
      @degree = DoctorDegree.pluck(:code)
      if current_user.has_role?(:admin) || current_user.has_role?(:data_entry)
        @degree += ['Not available']
      end
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

      if current_user.has_role?(:admin) || current_user.has_role?(:data_entry)
        @services += ['Not available']
      end

      respond_to do |format|
        format.json do
          render json: @services.as_json
        end
      end
    end

    def languages
      @languages = Language.pluck(:name)

      if current_user.has_role?(:admin) || current_user.has_role?(:data_entry)
        @languages += ['Not available']
      end

      respond_to do |format|
        format.json do
          render json: @languages.as_json
        end
      end
    end
  end
end
