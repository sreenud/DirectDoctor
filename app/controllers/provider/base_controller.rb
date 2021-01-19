module Provider
  class BaseController < ApplicationController
    include Pundit
    include Pagy::Backend

    layout "provider"
    before_action :authenticate_doctor!
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
      redirect_to((request.referrer || admin_dashboard_path), alert: "Not authorized to perform this action")
    end

    def authenticate_doctor!
      if current_user.present? && doctor_roles
        true
      else
        redirect_to(root_path)
      end
    end

    def doctor_roles
      doctor_roles = Role.doctor_roles.pluck(:name)
      current_user_roles = current_user.roles.pluck(:name)

      if (doctor_roles & current_user_roles).present?
        true
      else
        false
      end
    end
  end
end
