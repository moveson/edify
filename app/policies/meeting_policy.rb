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

  def music?
    index?
  end

  def edit_contributors?
    user.present?
  end

  def update_contributors?
    edit_contributors?
  end
end
