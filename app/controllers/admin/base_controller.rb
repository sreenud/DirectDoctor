module Admin
  class BaseController < ApplicationController
    include Pundit

    layout "admin"
    before_action :authenticate_admin!
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
      redirect_to((request.referrer || admin_dashboard_path), alert: "Not authorized to perform this action")
    end

    def authenticate_admin!
      if current_user.present? && admin_roles
        true
      else
        redirect_to(root_path)
      end
    end

    def admin_roles
      master_roles = Role.master_roles.pluck(:name)
      current_user_roles = current_user.roles.pluck(:name)

      if (master_roles & current_user_roles).present?
        true
      else
        false
      end
    end
  end
end
