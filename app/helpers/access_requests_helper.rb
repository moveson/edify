# frozen_string_literal: true

module AccessRequestsHelper
  def select_options_for_user_role
    select_array = AccessRequest::ASSIGNABLE_ROLES.map { |role| [role.titleize, role] }

    options_for_select(select_array, "")
  end
end
