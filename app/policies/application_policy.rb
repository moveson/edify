# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.assigned_to_unit?
  end

  def show?
    user.assigned_to_unit?
  end

  def create?
    user.assigned_to_unit?
  end

  def new?
    user.assigned_to_unit?
  end

  def update?
    user.assigned_to_unit?
  end

  def edit?
    user.assigned_to_unit?
  end

  def destroy?
    user.assigned_to_unit?
  end

  def upsert?
    user.assigned_to_unit?
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
