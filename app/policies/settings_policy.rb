class SettingsPolicy < ApplicationPolicy
  def preferences?
    user.present?
  end

  def avatar?
    preferences?
  end

  def password?
    preferences?
  end

  def update?
    preferences?
  end

  def remove_avatar?
    preferences?
  end
end
