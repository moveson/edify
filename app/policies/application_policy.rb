# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.access_to_lcr?
  end

  def show?
    user.access_to_lcr?
  end

  def create?
    user.unit_admin?
  end

  def new?
    user.unit_admin?
  end

  def update?
    user.unit_admin?
  end

  def edit?
    user.unit_admin?
  end

  def destroy?
    user.unit_admin?
  end

  def upsert?
    user.unit_admin?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
