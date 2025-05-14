class UserPolicy < ApplicationPolicy
  def index?
    user.present? &&
      user.assigned_to_unit?
  end

  def show?
    edit?
  end

  def edit?
    user.unit_admin? &&
      record.unit_id == user.unit_id
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
