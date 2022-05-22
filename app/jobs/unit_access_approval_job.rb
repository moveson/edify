# frozen_string_literal: true

class UnitAccessApprovalJob < ::ApplicationJob
  queue_as :default

  def perform(unit:, user:)
    ::UnitAccessApprovalNotification.with(user: user).deliver_later(unit.users.approvers)
  end
end
