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

  def edit_program_members?
    user.present?
  end

  def update_program_members?
    edit_program_members?
  end
end
