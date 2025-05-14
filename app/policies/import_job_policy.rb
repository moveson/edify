class ImportJobPolicy < ApplicationPolicy
  def new?
    user.access_to_lcr?
  end

  def create?
    new?
  end

  def destroy?
    new?
  end
end
