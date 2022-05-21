# frozen_string_literal: true

class MeetingPolicy < ApplicationPolicy
  def index?
    user.assigned_to_unit?
  end

  def show?
    user.assigned_to_unit?
  end
end
