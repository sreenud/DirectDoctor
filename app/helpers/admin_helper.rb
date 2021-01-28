
module AdminHelper
  # def admin_menu_active_classes(controller_name, action_name)
  #   if current_page?(controller: controller_name, action: action_name)
  #     { text_class: "text-blue-400", hover_text_class: "text-gray-100", hover_border_class: "border-blue-400" }
  #   else
  #     { text_class: "text-gray-500", hover_text_class: "text-gray-100", hover_border_class: "border-color-gco" }
  #   end
  # end

  ACTIVE_CLASS = {
    active_class: "text-indigo-900 border-l-2  border-indigo-900 font-bold",
  }.freeze

  INACTIVE_CLASS = {
    active_class: "text-gray-600",
  }.freeze

  def admin_menu_classes(options)
    name_of_controller = options.fetch(:controller) { nil }
    name_of_action     = options.fetch(:action) { nil }
    request_path       = options.fetch(:path) { nil }

    return ACTIVE_CLASS if request_path && request_path == request.path

    if name_of_controller == controller_name
      return ACTIVE_CLASS if name_of_action.nil? || (name_of_action == action_name)
    end

    INACTIVE_CLASS
  end

  def status_style(status)
    "#{status}-badge"
  end

  def master_role?
    master_roles = Role.master_roles.pluck(:name)
    current_user_roles = current_user.roles.pluck(:name)

    if (master_roles & current_user_roles).present?
      true
    else
      false
    end
  end

  def doctor_role?
    current_user_roles = current_user.roles.pluck(:name)

    if current_user_roles.include?('doctor')
      true
    else
      false
    end
  end

  def profile_approved?
    claim_request = ClaimProfileRequest.where(user_id: current_user.id)
      .where(status: 'requested')&.first

    return true unless claim_request
  end

  def request_approval_check(field_name, approvel_request)
    if approvel_request && approvel_request.params[field_name].present?
      "bg-indigo-300"
    end
  end
end
