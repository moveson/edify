# frozen_string_literal: true

class SongPolicy < ApplicationPolicy
  def new?
    user.music_editor?
  end

  def create?
    new?
  end

  def edit?
    new?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end
end
