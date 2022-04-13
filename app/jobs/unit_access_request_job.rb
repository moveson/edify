# frozen_string_literal: true

class UnitAccessRequestJob < ::ApplicationJob
  queue_as :default

  def perform(unit:, user:)
    ::UnitAccessRequestNotification.with(user: user).deliver_later(unit.users)
  end
end
