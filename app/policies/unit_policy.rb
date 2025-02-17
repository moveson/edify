class UnitPolicy < ApplicationPolicy
  def new?
    user.needs_onboarding?
  end

  def edit?
    user.unit_admin? &&
      user.unit_id == record.id
  end

  def create?
    new?
  end

  def update?
    edit?
  end

  def song_last_sung?
    user.music_editor?
  end

  def speaker_last_spoke?
    user.unit_admin?
  end
end
