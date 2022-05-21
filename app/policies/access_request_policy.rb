# frozen_string_literal: true

class AccessRequestPolicy < ApplicationPolicy
  def new?
    user.needs_onboarding?
  end

  def create?
    new?
  end

  def review?
    approve?
  end

  def approve?
    user.approver? &&
      user.unit_id == record.unit_id
  end

  def reject?
    approve?
  end

  def destroy?
    approve?
  end
end
