# frozen_string_literal: true

class UnitPolicy < ApplicationPolicy
  def edit?
    user.unit_id == record.id
  end

  def create?
    user.unit_id.nil?
  end

  def update?
    edit?
  end
end
