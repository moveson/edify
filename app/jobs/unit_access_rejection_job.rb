class UnitAccessRejectionJob < ::ApplicationJob
  queue_as :default

  def perform(unit:, user:)
    ::UnitAccessRejectionNotification.with(user: user).deliver_later(unit.users.approvers)
  end
end
