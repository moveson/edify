# frozen_string_literal: true

class UnitPolicy < ApplicationPolicy
  def new?
    user.needs_onboarding?
  end

  def edit?
    user.approver? &&
      user.unit_id == record.id
  end

  def create?
    new?
  end

  def update?
    edit?
  end
end
