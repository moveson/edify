# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    user.present? && user.assigned_to_unit?
  end
end
