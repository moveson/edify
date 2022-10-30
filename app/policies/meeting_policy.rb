# frozen_string_literal: true

class MeetingPolicy < ApplicationPolicy
  def index?
    user.assigned_to_unit?
  end

  def show?
    user.assigned_to_unit?
  end

  def create?
    user.music_editor?
  end

  def new?
    user.music_editor?
  end

  def update?
    user.music_editor?
  end

  def edit?
    user.music_editor?
  end
end
