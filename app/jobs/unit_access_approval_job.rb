# frozen_string_literal: true

class UnitAccessApprovalJob < ::ApplicationJob
  queue_as :default

  def perform(unit:, user:)
    user.access_request.destroy if user.access_request.present?

    ::UnitAccessApprovalNotification.with(user: user).deliver_later(unit.users)
  end
end
