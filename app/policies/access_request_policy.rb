# frozen_string_literal: true

class AccessRequestPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def new?
    user.needs_onboarding?
  end

  def create?
    new?
  end

  def update?
    user.unit_id == resource.unit_id
  end

  def destroy?
    update?
  end
end
